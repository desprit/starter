FROM nginx

# RUN apt-get update &&\
#   apt-get install -y curl &&\
#   curl -sL https://deb.nodesource.com/setup_10.x | bash &&\
#   apt-get update &&\
#   apt-get install -y nodejs curl nano

COPY myproject.conf /etc/nginx/conf.d/myproject.conf
RUN rm /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443
