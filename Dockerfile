# Use a standard base with common build tools
FROM ubuntu:22.04

# Install dependencies for build and dev tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    curl \
    python3 \
    python3-pip \
    vim \
    less \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /mlc-llm

# Copy the source code into the container at build time (optional, since dev mode mounts source)
COPY . .

# Add build scripts or ensure they're executable if needed
# RUN chmod +x ./scripts/build.sh

# Entrypoint script to switch modes based on environment variable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["dev"]
