# Information

A starter for Web apps of four Docker services: 
- Python API
- VueJS frontend
- Nginx reverse proxy
- Redis database

# Running

```sh
# Generate SSL certificates
make certificates
# Create log folders
make prepare
# Install frontend dependencies
cd web && yarn install
# Run docker-compose stack
make up
```

To make Web service respond on https://web.myproject.test url add the following to `/etc/hosts`:

```sh
127.0.0.1 web.myproject.test
```

# Test it working

Nagivate to https://web.myproject.test, you should see VueJS default starter page.

Send request to Python API:

```sh
curl https://web.myproject.test/ping
```

# Terminating

```sh
make down
```

# Troubleshooting

1. SSL certificate not accepted by the browser

Happens to me on MacOS. Would keep showing "Your connection is not private" and wouldn't let me open the page. Type "thisisunsafe" to fix that.