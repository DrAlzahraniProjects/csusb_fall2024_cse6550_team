# Dockerfile
FROM python:3.11

# Set the working directory
WORKDIR /app

# Install Mamba and Jupyter
RUN pip install mamba jupyter

# Copy the requirements file into the container
COPY requirements.txt requirements.txt

# Install the Python dependencies
RUN pip install -r requirements.txt

# Copy the Streamlit app into the container
COPY app.py app.py

# Expose port 5000
EXPOSE 5000

# Command to run the Streamlit app
CMD ["python", "app.py"]
