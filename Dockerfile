# Stage 1: Base for x86_64
FROM debian:bullseye-slim AS base-x86_64
RUN apt-get update && apt-get install -y curl bzip2
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-64/latest | tar -xvjf - -C /opt/micromamba && \
    ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba

# Stage 2: Base for ARM64
FROM arm64v8/debian:bullseye-slim AS base-arm64
RUN apt-get update && apt-get install -y curl bzip2
RUN curl -L https://micromamba.snakepit.net/api/micromamba/linux-arm64/latest | tar -xvjf - -C /opt/micromamba && \
    ln -s /opt/micromamba/bin/micromamba /usr/local/bin/micromamba

# Stage 3: Build the final image
FROM debian:bullseye-slim AS final
ARG ARCHITECTURE
COPY --from=base-${ARCHITECTURE} /opt/micromamba /opt/micromamba
COPY --from=base-${ARCHITECTURE} /usr/local/bin/micromamba /usr/local/bin/micromamba

# Install necessary packages and Nginx
RUN apt-get update && apt-get install -y nginx supervisor
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

# Start Supervisor
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
