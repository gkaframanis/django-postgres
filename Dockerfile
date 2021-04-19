# A Docker image is a snapshot in time of what a project contains. It is represented by the Dockerfile
# and is literally a list of instructions that must be built.
# Pull base image
FROM python:3.9

# Set environment variables
# PYTHONDONTWRITEBYTECODE means python will not try to write .pyc files which also we do not desire.
ENV PYTHONDONTWRITEBYTECODE 1
# PYTHONUNBUFFERED ensures our console output looks familiar and not buffered by Docker, which we don't want.
ENV PYTHONUNBUFFERED 1

# Set work directory within our image.
WORKDIR /code

# Install dependencies
# We copy over both Pipfile and Pipfile.lock files into a /code/ directory in Docker.
COPY Pipfile Pipfile.lock /code/
# Now the Docker container is our virtual environment
# We must use the --system flag to ensure our packages are available thoughout all of Docker for us.
RUN pip install pipenv && pipenv install --system

# Copy project
# Images are created based on instructions top-down so we want things that change often -like our local code - to be last.
COPY . /code/