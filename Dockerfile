# Base image: Using Micromamba
FROM mambaorg/micromamba:1.4.2-bullseye-slim

# Set the environment variables for Mamba
ENV MAMBA_DOCKERFILE_ACTIVATE=1
ENV MAMBA_ENV=app_env

# Ensure we are running as root
USER root

# Create the /app directory and set it as the working directory
WORKDIR /app

# Copy environment.yml for Mamba environment setup
COPY environment.yml /app/environment.yml

# Fix permission issues for apt-get
RUN mkdir -p /var/lib/apt/lists/partial && \
    chmod 755 /var/lib/apt/lists/partial && \
    apt-get update && \
    apt-get install -y nginx supervisor curl && \
    micromamba create --name ${MAMBA_ENV} --file /app/environment.yml && \
    micromamba clean --all --yes && \
    rm -rf /var/lib/apt/lists/*

# Copy application files (e.g., app.py, supervisor config, nginx config, etc.)
COPY app.py /app/app.py
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose the required ports
EXPOSE 80 5005

# Entry point for the application
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
