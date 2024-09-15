# Use an official base image for compatibility with all platforms
FROM mambaorg/micromamba:1.4.2

# Set the environment variables for Mamba
ENV MAMBA_DOCKERFILE_ACTIVATE=1
ENV MAMBA_ENV=app_env

# Create the /app directory
WORKDIR /app

# Copy the environment.yml for Mamba environment setup
COPY environment.yml /app/environment.yml

# Install system dependencies (nginx, supervisor) and create Mamba environment
RUN apt-get update && \
    apt-get install -y nginx supervisor curl && \
    micromamba create --name ${MAMBA_ENV} --file /app/environment.yml && \
    micromamba clean --all --yes && \
    rm -rf /var/lib/apt/lists/*

# Copy app and configuration files
COPY app.py /app/app.py
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the necessary port
EXPOSE 80

# Start Supervisor to manage both nginx and the app
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
