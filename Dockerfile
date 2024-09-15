# Use a base image suitable for your architecture (ARM64 for Apple M1)
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

# Copy requirements.txt and install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application files
COPY . /app

# Expose ports for Streamlit and Jupyter
EXPOSE 5005 50051

# Command to start Streamlit and Jupyter Notebook
CMD ["sh", "-c", "streamlit run app.py --server.port 5005 --server.address 0.0.0.0 & jupyter notebook --ip=0.0.0.0 --port=50051 --no-browser --allow-root"]
