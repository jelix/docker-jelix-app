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

if [ ! -d $DOCKERDATA/mysql ]; then
    mkdir -p $DOCKERDATA/mysql
fi

sudo chown root:root $DOCKERDATA/mysql
sudo chmod 777 $DOCKERDATA/mysql
 
sudo chown :www-data $BASE_PATH/temp/$APP_NAME/ $APP_PATH/var/log
chmod g+w $BASE_PATH/temp/$APP_NAME/ $APP_PATH/var/log

docker build -t $IMAGE_NAME .
