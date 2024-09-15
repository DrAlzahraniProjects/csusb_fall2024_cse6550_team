# Start with a different base image
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (nginx, supervisor, curl, bzip2)
RUN apt-get update && \
    apt-get install -y nginx supervisor curl bzip2 && \
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

# Expose ports for Nginx, Streamlit, and Jupyter
EXPOSE 80 5005 8501

# Start Supervisor to manage processes
CMD ["supervisord", "-c", "/app/supervisord.conf"]
