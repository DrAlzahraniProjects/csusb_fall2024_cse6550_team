import streamlit as st

# Your Streamlit app code
st.title("Hello, Streamlit!")

# Ensure the app runs on port 5005
if __name__ == "__main__":
    st.run("app.py", server_port=5005, server_address="0.0.0.0")
