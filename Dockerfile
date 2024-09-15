# Use a base image appropriate for your platform
FROM debian:bullseye-slim AS base

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bzip2 \
    python3 \
    python3-pip \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Determine the architecture and install Micromamba
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest -o micromamba-linux-64.tar.bz2 && \
        tar -xvjf micromamba-linux-64.tar.bz2 -C /opt/micromamba && \
        ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl -L https://micromamba.snakepit.net/api/micromamba/linux-arm64/latest -o micromamba-linux-arm64.tar.bz2 && \
        tar -xvjf micromamba-linux-arm64.tar.bz2 -C /opt/micromamba && \
        ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba; \
    else \
        echo "Unsupported architecture: $ARCH"; \
        exit 1; \
    fi

# Expose necessary ports
EXPOSE 80 5005 8888

# Copy application files and configure the server
COPY . /app
WORKDIR /app

# Start the application
CMD ["python3", "app.py"]
