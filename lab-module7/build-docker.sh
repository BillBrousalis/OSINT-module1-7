#!/bin/bash

IMAGE_NAME="lab-module7"
PORT=8080

echo ""
echo "================================================"
echo "  OSINT Course — Module 7 Lab Environment"
echo "================================================"
echo ""

if ! command -v docker &> /dev/null; then
    echo "[ERROR] Docker is not installed or not in PATH."
    echo "        Install it from https://docs.docker.com/get-docker/"
    exit 1
fi

EXISTING=$(docker ps -q --filter "ancestor=${IMAGE_NAME}")
if [ -n "$EXISTING" ]; then
    echo "[INFO] Lab is already running."
    echo ""
    echo "  Visit: http://localhost:${PORT}"
    echo ""
    exit 0
fi

echo "[1/2] Building Docker image — this may take a few minutes on first run..."
echo ""

docker build -t "${IMAGE_NAME}" .

if [ $? -ne 0 ]; then
    echo ""
    echo "[ERROR] Docker build failed. Check the output above for details."
    exit 1
fi

echo ""
echo "[2/2] Starting lab container..."
echo ""

docker run -d \
    --name "${IMAGE_NAME}" \
    --rm \
    -p ${PORT}:8080 \
    "${IMAGE_NAME}"

if [ $? -ne 0 ]; then
    echo "[ERROR] Failed to start container."
    echo "        If a container named '${IMAGE_NAME}' already exists, run:"
    echo "        docker rm -f ${IMAGE_NAME}"
    exit 1
fi

echo ""
echo "================================================"
echo "  Lab is ready."
echo ""
echo "  Open your browser and visit:"
echo "  http://localhost:${PORT}"
echo ""
echo "  To stop the lab, run:"
echo "  docker stop ${IMAGE_NAME}"
echo "================================================"
echo ""
