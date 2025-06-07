DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SH=`basename "$0"`
CONFIG_FILENAME="${SH/.sh/}"
source $DIR/../.env

cat <<EOF > $DIR/../output/$CONFIG_FILENAME
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${APP}
  namespace: ${NAMESPACE}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${APP}
  template:
    metadata:
      labels:
        app: ${APP}
    spec:
      containers:
        - image: ${IMAGE}
          imagePullPolicy: Always
          name: ${APP}
          ports:
            - containerPort: ${PORT}
              name: http
          envFrom:
            - configMapRef:
                name: ${APP}-config
EOF
