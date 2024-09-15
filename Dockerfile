# Use the official Python slim image that supports both ARM and x86_64 architectures
FROM python:3.9-slim-bullseye

# Set the working directory
WORKDIR /app

# Install system dependencies (curl, bzip2, and Python 3)
RUN apt-get update && \
    apt-get install -y curl bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements.txt and install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy application files
COPY . /app

# Expose ports for Streamlit (5005) and Jupyter Notebook (50051)
EXPOSE 5005 50051

# Command to start Streamlit on port 5005 and Jupyter Notebook on port 50051
CMD ["sh", "-c", "streamlit run app.py --server.port 5005 --server.address 0.0.0.0 & jupyter notebook --ip=0.0.0.0 --port=50051 --no-browser --allow-root"]
