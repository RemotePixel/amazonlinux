#!/bin/bash
# Highly inpired by https://github.com/keithrozario/Klayers/tree/master/scripts/deploy_with_docker
echo "-------------------"
echo "Fix Permission for Lambda Layer"
echo "-------------------"

LAYER_NAME=$1
GDAL_VERSION=$2
PYTHON_VERSION=$3

AWS_REGIONS=( 
    ap-northeast-1 ap-northeast-2
    ap-south-1
    ap-southeast-1 ap-southeast-2
    ca-central-1
    eu-central-1
    eu-north-1
    eu-west-1 eu-west-2 eu-west-3
    sa-east-1
    us-east-1 us-east-2
    us-west-1 us-west-2
)

PYTHON_VERSION_NODOT="${PYTHON_VERSION//.}"
GDAL_VERSION_NODOT="${GDAL_VERSION//.}"

LAYER_RUNTIME=python${PYTHON_VERSION}
LNAME=gdal${GDAL_VERSION_NODOT}-py${PYTHON_VERSION_NODOT}-${LAYER_NAME}

echo "Deploying ${LNAME}"
for AWS_REGION in "${AWS_REGIONS[@]}"; do
    # Get hash of latest version
    echo "List Layer in ${AWS_REGION}"
    LIST_LAYERS=$(aws lambda list-layer-versions --compatible-runtime ${LAYER_RUNTIME} --layer-name ${LNAME} --region ${AWS_REGION})
    AWS_LAYER_VERSION=$(jq -r '.LayerVersions[0].Version' <<< "${LIST_LAYERS}")

    if [[ $AWS_LAYER_VERSION = "null" ]];
    then
        echo "No Layer"
    else
        echo "Fix permissions for version: ${AWS_LAYER_VERSION}"
        aws lambda add-layer-version-permission \
            --region ${AWS_REGION} \
            --layer-name ${LNAME} \
            --statement-id make_public \
            --version-number ${AWS_LAYER_VERSION} \
            --principal '*' \
            --action lambda:GetLayerVersion
    fi
done
