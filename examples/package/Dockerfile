# Here we create a package (like previously with amazonlambda-gdal)
# we use the "-build" image because we don't want need pre-installed libaries
FROM remotepixel/amazonlinux:gdal3.0-py3.7

ENV PACKAGE_PREFIX=/var/task

COPY handler.py ${PACKAGE_PREFIX}/handler.py
RUN pip install numpy rasterio mercantile --no-binary :all: -t ${PACKAGE_PREFIX}/