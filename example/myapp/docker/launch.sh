#!/bin/bash
APP_PATH=$(dirname $0)/..
APP_PATH=`cd $APP_PATH && pwd`
APP_NAME=$(basename $APP_PATH)
BASE_PATH=`cd $APP_PATH/.. && pwd`

IMAGE_NAME="$1"
if [ "$IMAGE_NAME" == "" ]; then
    IMAGE_NAME="jelix-app/$APP_NAME"
fi

DOCKERDATA=$HOME/tmp/dockerdata/$IMAGE_NAME

docker run -d -p 8085:80 -p 3307:3306 -p 2223:22 -v $DOCKERDATA/mysql:/var/lib/mysql:rw -v $BASE_PATH:/var/www:rw $IMAGE_NAME 2>&1
 
