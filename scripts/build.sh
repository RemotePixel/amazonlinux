#!/bin/bash

GDAL_VERSION=$1
PYTHON_VERSION=$2
NAME=$3
echo "Building image for GDAL: ${GDAL_VERSION} - Python ${PYTHON_VERSION} - Layer: ${NAME}"
docker build -f base/gdal${GDAL_VERSION}/Dockerfile -t remotepixel/amazonlinux:gdal${GDAL_VERSION} .
docker build \
  --build-arg PYTHON_VERSION=${PYTHON_VERSION}\
  --build-arg GDAL_VERSION=${GDAL_VERSION} \
  -f layers/${NAME}/Dockerfile \
  -t remotepixel/amazonlinux:gdal${GDAL_VERSION}-py${PYTHON_VERSION}-${NAME} .
