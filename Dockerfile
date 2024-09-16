# Use a base image with Miniconda installed for Mamba
FROM continuumio/miniconda3

# Set the working directory
WORKDIR /app

# Copy the application files to the container
COPY . /app

# Install Mamba
RUN conda install mamba -c conda-forge

# Install dependencies from requirements.txt
RUN mamba install --file requirements.txt

# Expose port for Streamlit
EXPOSE 5005

# Run the app
CMD ["python", "app.py"]
