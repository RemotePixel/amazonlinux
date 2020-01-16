#!/bin/bash
echo "-----------------------"
echo "Creating lambda layer"
echo "-----------------------"

NAME=$1

ARCHIVE_NAME=layer-${NAME}

echo "Remove lambda python packages"
rm -rdf $PREFIX/python/boto3/ \
&& rm -rdf $PREFIX/python/botocore/ \
&& rm -rdf $PREFIX/python/docutils/ \
&& rm -rdf $PREFIX/python/dateutil/ \
&& rm -rdf $PREFIX/python/jmespath/ \
&& rm -rdf $PREFIX/python/s3transfer/ \
&& rm -rdf $PREFIX/python/numpy/doc/

echo "Remove useless files"
rm -rdf $PREFIX/share/doc \
&& rm -rdf $PREFIX/share/man \
&& rm -rdf $PREFIX/share/hdf*

echo "Remove uncompiled python scripts"
find $PREFIX/python -type f -name '*.pyc' | while read f; do n=$(echo $f | sed 's/__pycache__\///' | sed 's/.cpython-[2-3][0-9]//'); cp $f $n; done;
find $PREFIX/python -type d -a -name '__pycache__' -print0 | xargs -0 rm -rf
find $PREFIX/python -type f -a -name '*.py' -print0 | xargs -0 rm -f

echo "Strip shared libraries"
cd $PREFIX && find lib -name \*.so\* -exec strip {} \;

echo "Create archives"
cd $PREFIX && zip -r9q /tmp/${ARCHIVE_NAME}.zip python
cd $PREFIX && zip -r9q --symlinks /tmp/${ARCHIVE_NAME}.zip lib/*.so* share
cd $PREFIX && zip -r9q --symlinks /tmp/${ARCHIVE_NAME}.zip bin/gdal* bin/ogr* bin/geos* bin/nearblack

cp /tmp/${ARCHIVE_NAME}.zip /local/${ARCHIVE_NAME}.zip
