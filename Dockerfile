# Use base image
FROM mambaorg/micromamba:1.4.2

# Make sure we are root (this should already be the case by default)
USER root

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

# Continue with the rest of your Dockerfile...
