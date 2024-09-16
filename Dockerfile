# Use Miniforge base image
FROM condaforge/mambaforge:latest

# Set working directory
WORKDIR /app

# Install necessary packages directly
RUN mamba install -c conda-forge streamlit

# Copy application files
COPY . /app

# Expose port
EXPOSE 5005

# Run the Streamlit application
CMD ["streamlit", "run", "app.py", "--server.port=5005", "--server.address=0.0.0.0"]
