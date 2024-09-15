# Start with a base image for ARM architecture
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2, python3, python3-pip)
RUN apt-get update && \
    apt-get install -y curl bzip2 python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniforge for ARM (Mamba)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    bash miniforge.sh -b -p /opt/miniforge && \
    ln -s /opt/miniforge/bin/mamba /usr/local/bin/mamba && \
    mamba --version

# Set the environment directory for Mamba
ENV MAMBA_PREFIX=/opt/miniforge
ENV PATH="/opt/miniforge/bin:$PATH"

# Create the environment using Mamba
COPY environment.yml /app/environment.yml
RUN mamba env create -f /app/environment.yml && \
    mamba clean --all --yes

# Install Jupyter
RUN mamba install -c conda-forge jupyter

# Copy application files
COPY . /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5005
EXPOSE 5005

# Command to run the Streamlit application
CMD ["streamlit", "run", "app.py", "--server.port=5005"]
