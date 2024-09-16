# Dockerfile

# Use Miniforge base image
FROM condaforge/mambaforge:latest

# Set working directory
WORKDIR /app

# Install Python and dependencies
COPY environment.yml /app/
RUN mamba env create -f environment.yml
RUN echo "source activate myenv" > ~/.bashrc
ENV PATH /opt/conda/envs/myenv/bin:$PATH

# Copy application files
COPY . /app

# Expose port
EXPOSE 5005

# Run the Streamlit application
CMD ["streamlit", "run", "app.py", "--server.port=5005", "--server.address=0.0.0.0"]
