#!/bin/bash
# Highly inpired by https://github.com/keithrozario/Klayers/tree/master/scripts/deploy_with_docker
echo "-------------------"
echo "Deploy Lambda Layer"
echo "-------------------"

LAYER_NAME=$1

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

LAYER_RUNTIME=python${PYTHON_VERSION}
LAYER_PREFIX=amazonlinux-gdal${GDAL_VERSION}-py
LNAME=${LAYER_PREFIX}${PYTHON_VERSION}-${LAYER_NAME}
LZIP_NAME=${LNAME}.zip
LAYER_DESC="Lambda Layer with GDAL${GDAL_VERSION} - ${LAYER_RUNTIME}"
LAYER_HASH = $(sha256 ${LZIP_NAME})

for AWS_REGION in "${AWS_REGIONS[@]}"; do
    # Get hash of latest version
    LIST_LAYERS=$(aws lambda list-layer-versions --compatible-runtime ${LAYER_RUNTIME} --layer-name ${LNAME} --region ${AWS_REGION})
    AWS_LAYER_VERSION=$(jq -r '.LayerVersions[0].Version' <<< "${LIST_LAYERS}")

    if [[ $LAYER_VERSION = "null" ]];
    then
        AWS_LAYER_DESC="dummy"
        AWS_LAYER_VERSION=1
    else
        AWS_LAYER=$(aws lambda get-layer-version --version-number ${AWS_LAYER_VERSION} --layer-name $LAYER_NAME --region $AWS_REGION)
        AWS_LAYER_DESC=$(jq -r '.Description' <<< "${GET_LAYER}")
        # increment version
        let "AWS_LAYER_VERSION++"
    fi


    if [[ $REQTXT_SHA256 != $LAYER_REQTXT_SHA256 ]];
    then
        aws lambda publish-layer-version \
        --region $AWS_REGION \
        --layer-name $LNAME \
        --zip-file fileb://$LZIP_NAME \
        --description "${LAYER_DESC} | ${LAYER_HASH}" \
        --compatible-runtimes ${LAYER_RUNTIME} \
        --license-info MIT

        aws lambda add-layer-version-permission \
            --region $AWS_REGION \
            --layer-name $LNAME \
            --statement-id make_public \
            --version-number ${AWS_LAYER_VERSION} \
            --principal '*' \
            --action lambda:GetLayerVersion
    fi
done
