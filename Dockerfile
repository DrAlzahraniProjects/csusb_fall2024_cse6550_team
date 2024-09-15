# Start with a base image for ARM architecture
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2, python3, python3-pip)
RUN apt-get update && \
    apt-get install -y curl bzip2 python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Mamba for faster package management (optional)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    bash miniforge.sh -b -p /opt/miniforge && \
    ln -s /opt/miniforge/bin/mamba /usr/local/bin/mamba && \
    mamba --version

# Set the environment directory for Mamba (optional)
ENV MAMBA_PREFIX=/opt/miniforge
ENV PATH="/opt/miniforge/bin:$PATH"

# Install Python packages from requirements.txt
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter (optional)
RUN mamba install -c conda-forge jupyter

# Copy application files
COPY . /app

# Expose port 5005
EXPOSE 5005

# Command to run the Streamlit application
CMD ["streamlit", "run", "app.py", "--server.port=5005"]
