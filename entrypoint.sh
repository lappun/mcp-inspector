#!/bin/bash

# set DIR as the current scripts directory
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo EXTERNAL_SERVER_PORT $EXTERNAL_SERVER_PORT
echo EXTERNAL_INSPECTOR_PROXY_ADDRESS $EXTERNAL_INSPECTOR_PROXY_ADDRESS
echo CLIENT_PORT $CLIENT_PORT
echo SERVER_PORT $SERVER_PORT

npm run build
npm start
