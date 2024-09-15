# Use a base image with the correct platform
FROM --platform=${TARGETPLATFORM} debian:bullseye-slim AS base

# Install common dependencies
RUN apt-get update && apt-get install -y curl bzip2 python3 python3-pip nginx supervisor

# Install Micromamba based on architecture
ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvjf - -C /opt/micromamba && \
        ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        curl -L https://micromamba.snakepit.net/api/micromamba/linux-arm64/latest | tar -xvjf - -C /opt/micromamba && \
        ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba; \
    else \
        echo "Unsupported platform: $TARGETPLATFORM"; \
        exit 1; \
    fi

# Set up the working directory
WORKDIR /app

# Copy environment file and install dependencies
COPY environment.yml /app/environment.yml
RUN micromamba create --name app_env --file /app/environment.yml && \
    micromamba clean --all --yes

# Copy application files
COPY . /app

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports
EXPOSE 80 5005 8888

# Command to run the application
CMD ["python3", "app.py"]
