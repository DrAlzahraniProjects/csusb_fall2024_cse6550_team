# Use a base image with Mambaforge installed
FROM mambaforge/mambaforge:latest

# Set the working directory
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Install dependencies from requirements.txt using Mamba
RUN mamba install --file requirements.txt

# Expose port for Streamlit
EXPOSE 5005

# Run the Streamlit app
CMD ["python", "app.py"]
