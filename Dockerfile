# Use the Miniconda base image
FROM continuumio/miniconda3

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .

# Create a Conda environment and install dependencies
RUN conda create -n myenv python=3.8 -y && \
    conda run -n myenv pip install -r requirements.txt && \
    conda clean --all --yes

# Install Streamlit and Jupyter
RUN conda run -n myenv pip install streamlit jupyter

# Expose port 5005 for Streamlit
EXPOSE 5005

# Command to run the Streamlit app
CMD ["conda", "run", "-n", "myenv", "streamlit", "run", "app.py", "--server.port=5005", "--server.baseUrlPath=/team5"]
