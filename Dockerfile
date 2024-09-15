# Start with a base image for ARM architecture
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (python3, pip)
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Mamba for ARM (Mamba-forge)
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

# Install required Python packages
RUN mamba activate base && \
    pip install -r requirements.txt

# Expose port 5005
EXPOSE 5005

# Command to run the application
CMD ["python", "app.py"]
