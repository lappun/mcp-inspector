#!/bin/bash

# set DIR as the current scripts directory
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source <(grep -v '^#' $DIR/.env.local | grep -v '^$' | sed 's/^/export /')

export EXTERNAL_SERVER_PORT=443
export CLIENT_PORT=8083
export SERVER_PORT=8084
echo EXTERNAL_SERVER_PORT $EXTERNAL_SERVER_PORT
echo EXTERNAL_INSPECTOR_PROXY_ADDRESS $EXTERNAL_INSPECTOR_PROXY_ADDRESS
echo CLIENT_PORT $CLIENT_PORT
echo SERVER_PORT $SERVER_PORT

npm start
