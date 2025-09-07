#!/bin/bash
set -e

echo "Building HBBR Debian package..."

# Build the package
dpkg-buildpackage -b -uc -us -d

# Move the .deb file to a known location
mkdir -p ../deb-output
mv ../*.deb ../deb-output/ || true

echo "Package built successfully!"
echo "Output files:"
ls -la ../deb-output/