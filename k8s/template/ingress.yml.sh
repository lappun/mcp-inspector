DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SH=`basename "$0"`
CONFIG_FILENAME="${SH/.sh/}"
source $DIR/../.env

HOSTDASH=$(echo $HOST | sed 's/\./-/g')

cat <<EOF > $DIR/../output/$CONFIG_FILENAME
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${APP}
  namespace: ${NAMESPACE}
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
    kubernetes.io/ingress.allow-http: "false"
    nginx.ingress.kubernetes.io/proxy-body-size: 1000m
    nginx.ingress.kubernetes.io/proxy-connect-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
    nginx.ingress.kubernetes.io/configuration-snippet: |
      more_set_headers "Access-Control-Allow-Origin: *";
      more_set_headers "Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS";
      more_set_headers "Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Parse-Application-Id, X-Parse-Session-Token";
      more_set_headers "Access-Control-Allow-Credentials: true";
spec:
  ingressClassName: public
  rules:
  - host: ${HOST}
    http:
      paths:
      - path: /
        pathType: ImplementationSpecific
        backend:
          service:
            name: ${APP}
            port:
              number: ${PORT}
  tls:
  - hosts:
    - ${HOST}
    secretName: ${HOSTDASH}-crt

EOF
