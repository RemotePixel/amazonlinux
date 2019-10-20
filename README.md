# amazonlinux

[![CircleCI](https://circleci.com/gh/RemotePixel/amazonlinux.svg?style=svg)](https://circleci.com/gh/RemotePixel/amazonlinux)

Create an **AWS lambda** like docker images and lambda layer with python 3 and GDAL.

Inspired from [developmentseed/geolambda](https://github.com/developmentseed/geolambda) and [mojodna/lambda-layer-rasterio](https://github.com/mojodna/lambda-layer-rasterio).

## Dockers images
### GDAL Versions - Based on lambci/lambda-base:build
  - **remotepixel/amazonlinux:gdal3.0**
  - **remotepixel/amazonlinux:gdal2.4**

### Python - Based on lambci/lambda:build-python*

- **3.0.1**
  - **remotepixel/amazonlinux:gdal3.0-py3.7**

- **2.4.2**
  - **remotepixel/amazonlinux:gdal2.4-py3.7**

Content: GDAL Libs and python with numpy and cython

### Layers*

- **3.0.1**
  - **remotepixel/amazonlinux:gdal3.0-py3.7-geo**

- **2.4.2**
  - **remotepixel/amazonlinux:gdal2.4-py3.7-geo**

Content: base + rasterio, gdal and shapely

Note: The `Layers` docker image are usefull when you want to create lambda package to be used in addition to the lambda layer. 

## Lambda Layers

- **gdal${version}-py${version}-geo**
  - rasterio
  - shapely
  - numpy
  - GDAL

  arn: **`arn:aws:lambda:{REGION}:524387336408:layer:gdal30-py37-geo**

#### Regions
- ap-northeast-1
- ap-northeast-2
- ap-south-1 
- ap-southeast-1
- ap-southeast-2
- ca-central-1
- eu-central-1
- eu-north-1
- eu-west-1
- eu-west-2
- eu-west-3
- sa-east-1
- us-east-1
- us-east-2
- us-west-1
- us-west-2

### Available drivers

<details>

```
$ gdalinfo --formats
  VRT -raster- (rw+v): Virtual Raster
  DERIVED -raster- (ro): Derived datasets using VRT pixel functions
  GTiff -raster- (rw+vs): GeoTIFF
  NITF -raster- (rw+vs): National Imagery Transmission Format
  RPFTOC -raster- (rovs): Raster Product Format TOC format
  ECRGTOC -raster- (rovs): ECRG TOC format
  HFA -raster- (rw+v): Erdas Imagine Images (.img)
  SAR_CEOS -raster- (rov): CEOS SAR Image
  CEOS -raster- (rov): CEOS Image
  JAXAPALSAR -raster- (rov): JAXA PALSAR Product Reader (Level 1.1/1.5)
  GFF -raster- (rov): Ground-based SAR Applications Testbed File Format (.gff)
  ELAS -raster- (rw+v): ELAS
  AIG -raster- (rov): Arc/Info Binary Grid
  AAIGrid -raster- (rwv): Arc/Info ASCII Grid
  GRASSASCIIGrid -raster- (rov): GRASS ASCII Grid
  SDTS -raster- (rov): SDTS Raster
  DTED -raster- (rwv): DTED Elevation Raster
  PNG -raster- (rwv): Portable Network Graphics
  JPEG -raster- (rwv): JPEG JFIF
  MEM -raster- (rw+): In Memory Raster
  JDEM -raster- (rov): Japanese DEM (.mem)
  ESAT -raster- (rov): Envisat Image Format
  BSB -raster- (rov): Maptech BSB Nautical Charts
  XPM -raster- (rwv): X11 PixMap Format
  BMP -raster- (rw+v): MS Windows Device Independent Bitmap
  DIMAP -raster- (rov): SPOT DIMAP
  AirSAR -raster- (rov): AirSAR Polarimetric Image
  RS2 -raster- (rovs): RadarSat 2 XML Product
  SAFE -raster- (rov): Sentinel-1 SAR SAFE Product
  ILWIS -raster- (rw+v): ILWIS Raster Map
  SGI -raster- (rw+v): SGI Image File Format 1.0
  SRTMHGT -raster- (rwv): SRTMHGT File Format
  Leveller -raster- (rw+v): Leveller heightfield
  Terragen -raster- (rw+v): Terragen heightfield
  ISIS3 -raster- (rw+v): USGS Astrogeology ISIS cube (Version 3)
  ISIS2 -raster- (rw+v): USGS Astrogeology ISIS cube (Version 2)
  PDS -raster- (rov): NASA Planetary Data System
  PDS4 -raster,vector- (rw+vs): NASA Planetary Data System 4
  VICAR -raster- (rov): MIPL VICAR file
  TIL -raster- (rov): EarthWatch .TIL
  ERS -raster- (rw+v): ERMapper .ers Labelled
  JP2OpenJPEG -raster,vector- (rwv): JPEG-2000 driver based on OpenJPEG library
  L1B -raster- (rovs): NOAA Polar Orbiter Level 1b Data Set
  FIT -raster- (rwv): FIT Image
  GRIB -raster- (rwv): GRIdded Binary (.grb, .grb2)
  RMF -raster- (rw+v): Raster Matrix Format
  WCS -raster- (rovs): OGC Web Coverage Service
  WMS -raster- (rwvs): OGC Web Map Service
  MSGN -raster- (rov): EUMETSAT Archive native (.nat)
  RST -raster- (rw+v): Idrisi Raster A.1
  INGR -raster- (rw+v): Intergraph Raster
  GSAG -raster- (rwv): Golden Software ASCII Grid (.grd)
  GSBG -raster- (rw+v): Golden Software Binary Grid (.grd)
  GS7BG -raster- (rw+v): Golden Software 7 Binary Grid (.grd)
  COSAR -raster- (rov): COSAR Annotated Binary Matrix (TerraSAR-X)
  TSX -raster- (rov): TerraSAR-X Product
  COASP -raster- (ro): DRDC COASP SAR Processor Raster
  R -raster- (rwv): R Object Data Store
  MAP -raster- (rov): OziExplorer .MAP
  KMLSUPEROVERLAY -raster- (rwv): Kml Super Overlay
  WEBP -raster- (rwv): WEBP
  PDF -raster,vector- (w+): Geospatial PDF
  Rasterlite -raster- (rwvs): Rasterlite
  MBTiles -raster,vector- (rw+v): MBTiles
  PLMOSAIC -raster- (ro): Planet Labs Mosaics API
  CALS -raster- (rwv): CALS (Type 1)
  WMTS -raster- (rwv): OGC Web Map Tile Service
  SENTINEL2 -raster- (rovs): Sentinel 2
  MRF -raster- (rw+v): Meta Raster Format
  PNM -raster- (rw+v): Portable Pixmap Format (netpbm)
  DOQ1 -raster- (rov): USGS DOQ (Old Style)
  DOQ2 -raster- (rov): USGS DOQ (New Style)
  PAux -raster- (rw+v): PCI .aux Labelled
  MFF -raster- (rw+v): Vexcel MFF Raster
  MFF2 -raster- (rw+): Vexcel MFF2 (HKV) Raster
  FujiBAS -raster- (rov): Fuji BAS Scanner Image
  GSC -raster- (rov): GSC Geogrid
  FAST -raster- (rov): EOSAT FAST Format
  BT -raster- (rw+v): VTP .bt (Binary Terrain) 1.3 Format
  LAN -raster- (rw+v): Erdas .LAN/.GIS
  CPG -raster- (rov): Convair PolGASP
  IDA -raster- (rw+v): Image Data and Analysis
  NDF -raster- (rov): NLAPS Data Format
  EIR -raster- (rov): Erdas Imagine Raw
  DIPEx -raster- (rov): DIPEx
  LCP -raster- (rwv): FARSITE v.4 Landscape File (.lcp)
  GTX -raster- (rw+v): NOAA Vertical Datum .GTX
  LOSLAS -raster- (rov): NADCON .los/.las Datum Grid Shift
  NTv1 -raster- (rov): NTv1 Datum Grid Shift
  NTv2 -raster- (rw+vs): NTv2 Datum Grid Shift
  CTable2 -raster- (rw+v): CTable2 Datum Grid Shift
  ACE2 -raster- (rov): ACE2
  SNODAS -raster- (rov): Snow Data Assimilation System
  KRO -raster- (rw+v): KOLOR Raw
  ROI_PAC -raster- (rw+v): ROI_PAC raster
  RRASTER -raster- (rw+v): R Raster
  BYN -raster- (rw+v): Natural Resources Canada's Geoid
  ARG -raster- (rwv): Azavea Raster Grid format
  RIK -raster- (rov): Swedish Grid RIK (.rik)
  USGSDEM -raster- (rwv): USGS Optional ASCII DEM (and CDED)
  GXF -raster- (rov): GeoSoft Grid Exchange Format
  NWT_GRD -raster- (rw+v): Northwood Numeric Grid Format .grd/.tab
  NWT_GRC -raster- (rov): Northwood Classified Grid Format .grc/.tab
  ADRG -raster- (rw+vs): ARC Digitized Raster Graphics
  SRP -raster- (rovs): Standard Raster Product (ASRP/USRP)
  BLX -raster- (rwv): Magellan topo (.blx)
  SAGA -raster- (rw+v): SAGA GIS Binary Grid (.sdat, .sg-grd-z)
  IGNFHeightASCIIGrid -raster- (rov): IGN France height correction ASCII Grid
  XYZ -raster- (rwv): ASCII Gridded XYZ
  HF2 -raster- (rwv): HF2/HFZ heightfield raster
  OZI -raster- (rov): OziExplorer Image File
  CTG -raster- (rov): USGS LULC Composite Theme Grid
  E00GRID -raster- (rov): Arc/Info Export E00 GRID
  ZMap -raster- (rwv): ZMap Plus Grid
  NGSGEOID -raster- (rov): NOAA NGS Geoid Height Grids
  IRIS -raster- (rov): IRIS data (.PPI, .CAPPi etc)
  PRF -raster- (rov): Racurs PHOTOMOD PRF
  RDA -raster- (ro): DigitalGlobe Raster Data Access driver
  EEDAI -raster- (ros): Earth Engine Data API Image
  DAAS -raster- (ro): Airbus DS Intelligence Data As A Service driver
  SIGDEM -raster- (rwv): Scaled Integer Gridded DEM .sigdem
  GPKG -raster,vector- (rw+vs): GeoPackage
  CAD -raster,vector- (rovs): AutoCAD Driver
  PLSCENES -raster,vector- (ro): Planet Labs Scenes API
  NGW -raster,vector- (rw+s): NextGIS Web
  GenBin -raster- (rov): Generic Binary (.hdr Labelled)
  ENVI -raster- (rw+v): ENVI .hdr Labelled
  EHdr -raster- (rw+v): ESRI .hdr Labelled
  ISCE -raster- (rw+v): ISCE raster
  HTTP -raster,vector- (ro): HTTP Fetching Wrapper
```

</details>


# Create a Lambda package

You can use the docker container to either build a full package (you provide all the libraries)
or adapt for the use of AWS Lambda layer.

## 1. Create full package (see [/examples/package](/examples/package))
This is like we used to do before (with remotepixel/amazonlinux-gdal images)

- dockerfile
```Dockerfile
# Here we create a package (like previously with amazonlambda-gdal)
# we use the "-build" image because we don't want need pre-installed libaries
FROM remotepixel/amazonlinux:gdal3.0-py3.7

ENV PACKAGE_PREFIX=/var/task

COPY handler.py ${PACKAGE_PREFIX}/handler.py
RUN pip install numpy rasterio mercantile --no-binary :all: -t ${PACKAGE_PREFIX}/
```

- package.sh
```bash
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
```

- commands
```bash
docker build --tag package:latest .
docker run --name lambda -w /var/task --volume $(shell pwd)/:/local -itd package:latest bash
docker exec -it lambda bash '/local/package.sh'
docker stop lambda
docker rm lambda
```

## 2. Use Lambda Layer (see [/examples/layer](/examples/layer))

- dockerfile

Here we install mercantile and we add our handler method. 
The final package structure should be 

```
package/
  |
  |___ handler.py  
  |___ mercantile/
```

Let's use `-geo` layer

```Dockerfile
FROM remotepixel/amazonlinux:gdal3.0-py3.7-geo

# Basically we don't want to replicated existant modules found in the layer ($PYTHONPATH)
# So we use the $PYTHONUSERBASE trick to set the output directory
ENV PYTHONUSERBASE=/var/task

# Create a package
COPY handler.py $PYTHONUSERBASE/handler.py
RUN pip install --user mercantile 
```
- layer.sh
```bash
# We move all the package to the root directory
version=$(python -c 'import sys; print(f"{sys.version_info[0]}.{sys.version_info[1]}")')
PYPATH=${PYTHONUSERBASE}/lib/python${version}/site-packages/
mv ${PYPATH}/* ${PYTHONUSERBASE}/
rm -rf ${PYTHONUSERBASE}/lib

echo "Create archive"
cd $PYTHONUSERBASE && zip -r9q /tmp/layer.zip *

cp /tmp/layer.zip /local/layer.zip
```
- commands
```bash
docker build --tag package:latest .
docker run --name lambda -w /var/task --volume $(shell pwd)/:/local -itd package:latest bash
docker exec -it lambda bash '/local/layer.sh'
docker stop lambda
docker rm lambda

```

### Docker environment variables
A couple environment variables are set when creating the images:

- **PREFIX**: Path where GDAL has been installed, shoud be `/opt`
- **GDAL_DATA**: `$PREFIX/share/gdal`
- **PROJ_LIB**: `$PREFIX/share/proj`
- **GDAL_CONFIG**: `$PREFIX/bin/gdal-config`
- **GEOS_CONFIG**: `$PREFIX/bin/geos-config`
- **PATH** has been updated to add `$PREFIX/bin` in order to access gdal binaries

# Package architecture and AWS Lambda config
### Simple config

```
package.zip
  |
  |___ lib/      # Shared libraries (GDAL, PROJ, GEOS...)
  |___ share/    # GDAL/PROJ data directories   
  |___ rasterio/
  ....
  |___ handler.py
  |___ other python module
```

##### Lambda config
- **GDAL_DATA:** /var/task/share/gdal
- **PROJ_LIB:** /var/task/share/proj


### When using Lambda layer

```
package.zip
  |
  |___ handler.py
  |___ other python module  
```

##### Lambda config
- **GDAL_DATA:** /var/task/share/gdal or /opt/share/gdal
- **PROJ_LIB:** /var/task/share/proj or /opt/share/proj


# Other variable for optimal config
- **GDAL_CACHEMAX:** 512
- **VSI_CACHE:** TRUE
- **VSI_CACHE_SIZE:** 536870912
- **CPL_TMPDIR:** "/tmp"
- **GDAL_HTTP_MERGE_CONSECUTIVE_RANGES:** YES
- **GDAL_HTTP_MULTIPLEX:** YES
- **GDAL_HTTP_VERSION:** 2
- **GDAL_DISABLE_READDIR_ON_OPEN:** "EMPTY_DIR"
- **CPL_VSIL_CURL_ALLOWED_EXTENSIONS:** ".TIF,.tif,.jp2,.vrt"


# Layer architecture

The AWS Layer created within this repository have this architecture:

```
layer.zip
  |
  |___ bin/      # Binaries
  |___ lib/      # Shared libraries (GDAL, PROJ, GEOS...)
  |___ share/    # GDAL/PROJ data directories   
  |___ python/
```