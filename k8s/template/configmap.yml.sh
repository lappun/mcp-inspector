DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SH=`basename "$0"`
CONFIG_FILENAME="${SH/.sh/}"
source $DIR/../.env

cat <<EOF > $DIR/../output/$CONFIG_FILENAME
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${APP}-config
  namespace: ${NAMESPACE}
  labels:
    app: ${APP}
data:
  TZ: "${TZ}"
  PORT: "${PORT}"
  APP: "${APP}"
  APP_ID: "${APP_ID}"
  EXTERNAL_SERVER_PORT: "${EXTERNAL_SERVER_PORT}"
  CLIENT_PORT: "${CLIENT_PORT}"
  SERVER_PORT: "${SERVER_PORT}"

EOF
