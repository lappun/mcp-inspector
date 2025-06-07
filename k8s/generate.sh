#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

mkdir -p $DIR/output

$DIR/template/configmap.yml.sh
$DIR/template/deployment.yml.sh
$DIR/template/service.yml.sh
$DIR/template/ingress.yml.sh
