SHELL := /bin/bash
.DEFAULT_GOAL := help
.PHONY: help \
	up \
	web \
	api \
	down \
	nginx

include configs/.${ENVIRONMENT}.env

certificates: ## Create SSL certificates
	@cd nginx && \
		openssl req -newkey rsa:2048 -x509 -nodes -keyout certs/server.key -new -out certs/server.crt -sha256 -days 365

prepare: ## Create log folders
	@sudo mkdir -p /var/log/myproject/nginx
	@sudo touch /var/log/myproject/nginx/err.log
	@sudo touch /var/log/myproject/nginx/out.log
	@sudo chown -R ${USER} /var/log/myproject/
	@sudo chmod 2775 /var/log/myproject/
	@find /var/log/myproject -type d -exec sudo chmod 2775 {} +
	@find /var/log/myproject -type f -exec sudo chmod 0664 {} +

up: ## Run Docker stack
	@docker info > /dev/null 2>&1 || sudo systemctl start docker
	@docker-compose -f configs/docker-compose.base.yml -f configs/docker-compose.${ENVIRONMENT}.yml build
	@docker-compose -f configs/docker-compose.base.yml -f configs/docker-compose.${ENVIRONMENT}.yml up -d
	@docker-compose -f configs/docker-compose.base.yml -f configs/docker-compose.${ENVIRONMENT}.yml logs -f --tail 20
	# @$(MAKE) logs

down: ## Shut down Docker stack and remove Docker volumes
	@docker-compose -f configs/docker-compose.base.yml -f configs/docker-compose.${ENVIRONMENT}.yml down -v

nginx: ## Connect to Nginx container
	@docker exec -it myproject_nginx /bin/bash

api: ## Connect to Web container
	@docker exec -it myproject_api /bin/bash

web: ## Connect to API container
	@docker exec -it myproject_web /bin/bash

help: ## This help dialog
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
	printf "%-30s %s\n" "target" "help" ; \
	printf "%-30s %s\n" "------" "----" ; \
	for help_line in $${help_lines[@]}; do \
		IFS=$$':' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf '\033[36m'; \
		printf "%-30s %s" $$help_command ; \
		printf '\033[0m'; \
		printf "%s\n" $$help_info; \
	done
