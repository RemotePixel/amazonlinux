#!/bin/bash
# [ "$#" -lt 3 ] && echo "Usage: create-lambda-layer <gdal-version> <python-version> " && exit 1

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
LAYER_PREFIX=amazonlinux-gdal${GDAL_VERSION}-py
deploy-layer () {
LAYER_RUNTIME=python${PYTHON_VERSION}
LAYER_RUNTIME_NODOT="${LAYER_RUNTIME//.}"  # removes . between 3.7
LZIP_NAME=$LAYER_PREFIX$LAYER_RUNTIME_NODOT-${LAYER_NAME}.zip
LNAME=$LAYER_PREFIX$LAYER_RUNTIME_NODOT-${LAYER_NAME}
LAYER_DESC="Lambda Layer with GDAL${GDAL_VERSION} - ${LAYER_RUNTIME}"

for AWS_REGION in "${AWS_REGIONS[@]}"; do
    # Get hash of latest version
    LIST_LAYERS=$(aws lambda list-layer-versions --compatible-runtime $LAYER_RUNTIME --layer-name $LNAME --region $AWS_REGION)
    LAYER_VERSION=$(jq -r '.LayerVersions[0].Version' <<< "${LIST_LAYERS}")


    if [[ $LAYER_VERSION = "null" ]];  # JQ will set value to null if unable to get the key
    then
        LAYER_REQTXT_SHA256="dummy"  #dummy so won't match SHA256
        LAYER_VERSION=1
    else
        GET_LAYER=$(aws lambda get-layer-version --version-number ${LAYER_VERSION} --layer-name $LAYER_NAME --region $AWS_REGION)
        GET_LAYER_DESC=$(jq -r '.Description' <<< "${GET_LAYER}")
        LAYER_REQTXT_SHA256=$(echo "${GET_LAYER_DESC}" | cut -d "|" -f 2)  # I include the SHA256 of requirements.txt into the description
        # increment version
        let "LAYER_VERSION++"
    fi

    # not the ideal, but let me explain ... I was too lazy
    if [[ $* == *-b* ]];
    then
        LAYER_REQTXT_SHA256="dummy"
    fi

    if [[ $REQTXT_SHA256 != $LAYER_REQTXT_SHA256 ]];
    then
        # deploy -- description is of format $LAYER_DESC |$REQTXT_SHA256
        aws lambda publish-layer-version \
        --region $AWS_REGION \
        --layer-name $LNAME \
        --zip-file fileb://$LZIP_NAME \
        --description "$LAYER_DESC | $REQTXT_SHA256" \
        --compatible-runtimes $LAYER_RUNTIME \
        --license-info $LAYER_LICENSE

        aws lambda add-layer-version-permission \
            --region $AWS_REGION \
            --layer-name $LNAME \
            --statement-id make_public \
            --version-number $LAYER_VERSION \
            --principal '*' \
            --action lambda:GetLayerVersion
    fi
    done
}