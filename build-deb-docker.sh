#!/bin/bash
set -e

echo "Building HBBR Debian package in Docker..."

# Build the Docker image
docker build -t rustdesk-hbbr-deb-builder -f Dockerfile.deb-builder .

# Create output directory
mkdir -p deb-output

# Run the build
docker run --rm \
    -v "$(pwd):/build" \
    -v "$(pwd)/deb-output:/build/deb-output" \
    -w /build \
    rustdesk-hbbr-deb-builder \
    bash -c "dpkg-buildpackage -b -uc -us -d && mv ../*.deb deb-output/ || true"

echo "Package built successfully!"
echo "Output files:"
ls -la deb-output/