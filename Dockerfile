# Use the Miniconda base image
FROM continuumio/miniconda3

# Set the working directory
WORKDIR /app

# Install a simple package to test
RUN conda create -n test-env python=3.8 -y && \
    conda run -n test-env pip install streamlit && \
    conda clean --all --yes

# Set environment variable for Streamlit
ENV STREAMLIT_SERVER_PORT=5005

# Command to run a simple command to verify the environment
CMD ["conda", "run", "-n", "test-env", "python", "-c", "import streamlit; print('Streamlit is installed!')"]
