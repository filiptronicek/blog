FROM mcr.microsoft.com/devcontainers/ruby:latest

# Install system dependencies including libvips
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libvips42 \
    libvips-dev \
    && rm -rf /var/lib/apt/lists/*

