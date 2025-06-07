DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SH=`basename "$0"`
CONFIG_FILENAME="${SH/.sh/}"
source $DIR/../.env

cat <<EOF > $DIR/../output/$CONFIG_FILENAME
---
apiVersion: v1
kind: Service
metadata:
  name: ${APP}
  namespace: ${NAMESPACE}
  labels:
    app: ${APP}
spec:
  ports:
   - port: ${CLIENT_PORT}
     name: client
   - port: ${SERVER_PORT}
     name: server
  selector:
   app: ${APP}

EOF