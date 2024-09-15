# Start with a different base image
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (nginx, supervisor, curl, bzip2)
RUN apt-get update && \
    apt-get install -y nginx supervisor curl bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Mambafor ARM (Mamba-forge)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge3-Linux-aarch64.sh -o mambaforge.sh && \
    bash mambaforge.sh -b -p /opt/mambaforge && \
    ln -s /opt/mambaforge/bin/mamba /usr/local/bin/mamba && \
    mamba --version

# Set the environment directory for Mamba
ENV MAMBA_PREFIX=/opt/mambaforge
ENV PATH="/opt/mambaforge/bin:$PATH"

# Create the Mamba environment
COPY environment.yml /app/environment.yml
RUN mamba env create -f /app/environment.yml && \
    mamba clean --all --yes

# Copy application files
COPY . /app

# Expose ports for Nginx, Streamlit
EXPOSE 80 5005

# Start Supervisor to manage processes
CMD ["supervisord", "-c", "/app/supervisord.conf"]
