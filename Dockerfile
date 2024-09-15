# Start with a different base image for ARM64 architecture
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (nginx, supervisor, curl, bzip2)
RUN apt-get update && \
    apt-get install -y curl bzip2 && \
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

# Create the Conda environment
COPY environment.yml /app/environment.yml
RUN conda env create -f /app/environment.yml && \
    conda clean --all --yes

# Copy application files
COPY . /app

# Install necessary Python packages if not included in environment.yml
RUN pip install --no-cache-dir -r requirements.txt

# Expose port for the application
EXPOSE 5005

# Set the command to run the application
CMD ["python", "app.py"]
