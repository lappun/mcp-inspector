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
          readinessProbe:
            exec:
              command:
                - /healthcheck.sh
            initialDelaySeconds: 20
            periodSeconds: 10
            successThreshold: 1
            failureThreshold: 20
          ports:
            - containerPort: ${PORT}
              name: http
          envFrom:
            - configMapRef:
                name: ${APP}-config
            - secretRef:
                name: ${APP}-secret
          volumeMounts:
            - name: ${APP}-pv
              mountPath: /app/data
              subPath: data
          # command: ["sleep", "infinity"]
      imagePullSecrets:
      - name: hkteamkey
      volumes:
      - name: ${APP}-pv
        persistentVolumeClaim:
          claimName: ${APP}-pvc
EOF
