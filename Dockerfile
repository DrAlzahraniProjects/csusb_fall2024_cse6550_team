# Use a base image suitable for ARM64 (Apple M1) architecture
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2)
RUN apt-get update && \
    apt-get install -y curl bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniforge for ARM (Conda-forge)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    bash miniforge.sh -b -p /opt/miniforge && \
    ln -s /opt/miniforge/bin/conda /usr/local/bin/conda && \
    conda --version

# Set environment variables for Conda
ENV CONDA_PREFIX=/opt/miniforge
ENV PATH="/opt/miniforge/bin:$PATH"

# Install Python 3.9 using Conda
RUN conda install --yes python=3.9

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application files
COPY . /app

# Expose the ports for Streamlit
EXPOSE 5005

# Command to run the Streamlit application directly with Python
CMD ["python", "app.py"]
