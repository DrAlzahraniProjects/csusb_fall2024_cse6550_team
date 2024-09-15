# Use a Python base image
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y nginx supervisor curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Micromamba
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvjf - -C /usr/local/bin

# Set the environment directory for Mamba
ENV MAMBA_DOCKERFILE_ACTIVATE=1
ENV MAMBA_ENV=app_env

# Set the working directory
WORKDIR /app

# Copy environment.yml for Mamba environment setup
COPY environment.yml /app/environment.yml

# Create Mamba environment
RUN micromamba create --name ${MAMBA_ENV} --file /app/environment.yml && \
    micromamba clean --all --yes

# Create directories for Nginx logs and PID file
RUN mkdir -p /var/run/nginx /var/log/nginx /run

# Copy application code
COPY . /app

# Copy configuration files
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx.conf /etc/nginx/sites-available/default

# Expose port 80 for HTTP access
EXPOSE 80

# Start supervisor to run nginx, streamlit, and jupyter
CMD ["micromamba", "run", "-n", "${MAMBA_ENV}", "supervisord", "-c", "/etc/supervisor/supervisord.conf"]
