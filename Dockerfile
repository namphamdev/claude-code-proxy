# Use an official Python runtime as a parent image
FROM python:3.10-slim-buster

# Set the working directory in the container
WORKDIR /app

# Install uv
# uv is a fast Python package installer and resolver, often much faster than pip.
RUN pip install uv

# Copy the current directory contents into the container at /app
# This assumes your server.py and requirements.txt (if any) are in the same directory as the Dockerfile.
COPY . /app

# Install any needed packages specified in requirements.txt using uv
# This step will only run if a requirements.txt file exists.
# If your project doesn't have a requirements.txt, you can comment out this line.
RUN if [ -f requirements.txt ]; then uv pip install -r requirements.txt; fi

# Make port 8082 available to the world outside this container
EXPOSE 8082

# Run the uvicorn server when the container launches
# The --reload flag is typically used for development. For production, you might remove it.
CMD ["uv", "run", "uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8082", "--reload"]
