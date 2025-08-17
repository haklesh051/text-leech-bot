# Base image (buster deprecated hai isliye bullseye use karein)
FROM python:3.10-slim-bullseye

# System dependencies install karo
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . /app/
WORKDIR /app/

# Install Python dependencies
RUN pip3 install --no-cache-dir --upgrade -r requirements.txt

# Start both Gunicorn (Flask app) and your bot
CMD gunicorn app:app --bind 0.0.0.0:$PORT & python3 modules/main.py
