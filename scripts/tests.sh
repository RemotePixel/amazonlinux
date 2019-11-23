#!/bin/bash
if [[ ! "$(gdal-config --prefix | grep $PREFIX)" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --version | grep $GDALVERSION)" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'openjpeg')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'gtiff')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'mbtiles')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'webp')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'jpeg')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(gdal-config --formats | grep 'png')" ]]; then echo "NOK" && exit 1; fi
if [[ ! "$(ogrinfo --formats | grep 'GML')" ]]; then echo "NOK" && exit 1; fi

echo "OK"
exit 0
