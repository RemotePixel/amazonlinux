ARG GDAL_VERSION
ARG PYTHON_VERSION

FROM remotepixel/amazonlinux:gdal${GDAL_VERSION}-py${PYTHON_VERSION}

# To Do 
# - add pyproj
# - add fiona (incompatible with gdal3.0)
RUN pip install \
    rasterio \
    shapely \
    numpy \
    pygeos \
    GDAL~=$(gdal-config --version) \
    --no-binary :all: -t $PREFIX/python

ENV PYTHONPATH=$PYTHONPATH:$PREFIX/python