# Start with a different base image
FROM debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (nginx, supervisor, curl, bzip2)
RUN apt-get update && \
    apt-get install -y nginx supervisor curl bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Micromamba
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvjf - -C /usr/local/bin && \
    ls -l /usr/local/bin

# Set the environment directory for Mamba
ENV MAMBA_PREFIX=/opt/micromamba
ENV PATH="$MAMBA_PREFIX/bin:/usr/local/bin:$PATH"

# Create the Mamba environment
COPY environment.yml /app/environment.yml
RUN micromamba create --name app_env --file /app/environment.yml && \
    micromamba clean --all --yes

# Copy application files
COPY . /app

# Expose ports
EXPOSE 80 5005 8888

# Start Supervisor to manage processes
CMD ["supervisord", "-c", "/app/supervisord.conf"]
