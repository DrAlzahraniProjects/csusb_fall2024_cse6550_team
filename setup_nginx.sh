#!/bin/bash

# Define Nginx configuration content
NGINX_CONF_CONTENT='
server {
    listen 5005;

    location /team {
        proxy_pass http://localhost:5005;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
    }
}
'

# Function to configure and restart Nginx
configure_and_restart_nginx() {
    echo "Configuring Nginx..."

    # Write the Nginx configuration to the file
    echo "$NGINX_CONF_CONTENT" > /etc/nginx/conf.d/default.conf

    echo "Restarting Nginx..."

    # Restart Nginx based on OS
    if [[ "$(uname -s)" == "Linux" ]]; then
        nginx -s reload
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        nginx -s reload
    elif [[ "$(uname -s)" == "MINGW"* || "$(uname -s)" == "MSYS"* ]]; then
        echo "Restart Nginx manually in Windows or use the command prompt"
    else
        echo "Unsupported OS: $(uname -s)"
        exit 1
    fi
}

# Check if Nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "Nginx is not installed. Please install Nginx first."
    exit 1
fi

# Execute the configuration and restart
configure_and_restart_nginx

echo "Nginx setup complete."
