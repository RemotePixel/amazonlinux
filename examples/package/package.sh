#!/bin/bash
echo "-----------------------"
echo "Creating lambda package"
echo "-----------------------"
echo "Remove lambda python packages"
rm -rdf $PACKAGE_PREFIX/boto3/ \
  && rm -rdf $PACKAGE_PREFIX/botocore/ \
  && rm -rdf $PACKAGE_PREFIX/docutils/ \
  && rm -rdf $PACKAGE_PREFIX/dateutil/ \
  && rm -rdf $PACKAGE_PREFIX/jmespath/ \
  && rm -rdf $PACKAGE_PREFIX/s3transfer/ \
  && rm -rdf $PACKAGE_PREFIX/numpy/doc/

echo "Strip shared libraries"
cd $PREFIX && find lib -name \*.so\* -exec strip {} \;

echo "Create archive"
cd $PACKAGE_PREFIX && zip -r9q /tmp/package.zip *
cd $PREFIX && zip -r9q --symlinks /tmp/package.zip lib/*.so* share bin
cp /tmp/package.zip /local/package.zip
