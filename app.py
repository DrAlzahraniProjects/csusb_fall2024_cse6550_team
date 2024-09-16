import streamlit as st
import os
import sys

def main():
    # Streamlit app code
    st.title("Hello, World!")

if __name__ == "__main__":
    # Ensure Streamlit runs on the correct port
    if 'streamlit' in sys.argv:
        main()
    else:
        # Set the environment variable for Streamlit to use port 5005
        os.environ['STREAMLIT_SERVER_PORT'] = '5005'
        import streamlit.cli
        streamlit.cli.main()
