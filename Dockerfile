# Start with a different base image
FROM arm64v8/debian:bullseye-slim

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2)
RUN apt-get update && \
    apt-get install -y curl bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Miniforge for ARM (Mamba-forge)
RUN curl -fsSL https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -o miniforge.sh && \
    bash miniforge.sh -b -p /opt/miniforge && \
    ln -s /opt/miniforge/bin/mamba /usr/local/bin/mamba && \
    mamba --version

# Set the environment directory for Mamba
ENV MAMBA_PREFIX=/opt/miniforge
ENV PATH="/opt/miniforge/bin:$PATH"

# Create the environment
COPY requirements.txt /app/requirements.txt
RUN mamba create -n myenv python=3.12 && \
    mamba install --name myenv --file /app/requirements.txt && \
    mamba clean --all --yes

# Install Jupyter Notebook
RUN mamba install -n myenv jupyter notebook

# Copy application files
COPY . /app

# Expose ports for Streamlit and Jupyter
EXPOSE 5005 8888

# Run Streamlit and Jupyter Notebook
CMD ["sh", "-c", "streamlit run app.py & jupyter notebook --ip 0.0.0.0 --port 8888 --no-browser --allow-root"]
