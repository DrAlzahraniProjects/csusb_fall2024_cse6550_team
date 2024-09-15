# Start with a different base image
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2, and Python 3)
RUN apt-get update && \
    apt-get install -y curl bzip2 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniforge for ARM (Conda-forge)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    bash miniforge.sh -b -p /opt/miniforge && \
    ln -s /opt/miniforge/bin/conda /usr/local/bin/conda && \
    conda --version

# Set the environment directory for Conda
ENV CONDA_PREFIX=/opt/miniforge
ENV PATH="/opt/miniforge/bin:$PATH"

# Install Jupyter and Python dependencies from requirements.txt
RUN conda install -c conda-forge jupyter && \
    pip install --no-cache-dir -r /app/requirements.txt

# Copy application files
COPY . /app

# Expose port 5005
EXPOSE 5005

# Command to run the application
CMD ["python3", "app.py"]
