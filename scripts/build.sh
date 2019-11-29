#!/bin/bash

GDAL_VERSION=$1
PYTHON_VERSION=$2
NAME=$3

echo "Building image for GDAL: ${GDAL_VERSION} - Python ${PYTHON_VERSION} - Layer: ${NAME}"
# GDAL
docker build -f base/gdal${GDAL_VERSION}/Dockerfile -t remotepixel/amazonlinux:gdal${GDAL_VERSION} .

# TEST
docker run \
  --name lambda \
  --volume $(pwd)/:/local \
  --env GDALVERSION=${GDAL_VERSION} \
  -itd remotepixel/amazonlinux:gdal${GDAL_VERSION} bash
docker exec -it lambda bash -c 'cd /local/tests/ && sh tests.sh'
docker stop lambda
docker rm lambda

# PYTHON
docker build \
  --build-arg PYTHON_VERSION=${PYTHON_VERSION}\
  --build-arg GDAL_VERSION=${GDAL_VERSION} \
  -f base/python/Dockerfile \
  -t remotepixel/amazonlinux:gdal${GDAL_VERSION}-py${PYTHON_VERSION} .

# LAYER
docker build \
  --build-arg PYTHON_VERSION=${PYTHON_VERSION}\
  --build-arg GDAL_VERSION=${GDAL_VERSION} \
  -f layers/${NAME}/Dockerfile \
  -t remotepixel/amazonlinux:gdal${GDAL_VERSION}-py${PYTHON_VERSION}-${NAME} .
