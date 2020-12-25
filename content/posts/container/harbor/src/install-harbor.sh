#!/bin/bash

set -e

DOMAIN="csc-registry:5000"
HOSTNAME="csc-registry:5000"
HARBOR_CERT_DIR="/opt/harbor/cert"
DOCKER_CERT_DIR="/etc/docker/certs.d/$DOMAIN"
CA_DIR="ca"

mkdir -p $CA_DIR
mkdir -p $HARBOR_CERT_DIR
mkdir -p $DOCKER_CERT_DIR

# Generate certificate
## Generate a CA certificate private key.
openssl genrsa -out $CA_DIR/ca.key 4096

## Generate the CA certificate.
openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=Shanghai/L=Shanghai/O=example/OU=Personal/CN=$DOMAIN" \
 -key $CA_DIR/ca.key \
 -out $CA_DIR/ca.crt

# Generate a Server Certificate
## Generate a private key.
openssl genrsa -out $CA_DIR/$DOMAIN.key 4096

## Generate a certificate signing request (CSR).
openssl req -sha512 -new \
    -subj "/C=CN/ST=Shanghai/L=Shanghai/O=example/OU=Personal/CN=$DOMAIN" \
    -key $CA_DIR/$DOMAIN.key \
    -out $CA_DIR/$DOMAIN.csr

## Generate an x509 v3 extension file
cat > $CA_DIR/v3.ext << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=$DOMAIN.com
DNS.2=$DOMAIN
DNS.3=$HOSTNAME
EOF

## Use the v3.ext file to generate a certificate for your Harbor host.
openssl x509 -req -sha512 -days 3650 \
    -extfile $CA_DIR/v3.ext \
    -CA $CA_DIR/ca.crt -CAkey $CA_DIR/ca.key -CAcreateserial \
    -in $CA_DIR/$DOMAIN.csr \
    -out $CA_DIR/$DOMAIN.crt

cp $CA_DIR/$DOMAIN.crt $HARBOR_CERT_DIR
cp $CA_DIR/$DOMAIN.key $HARBOR_CERT_DIR

openssl x509 -inform PEM -in $CA_DIR/$DOMAIN.crt -out $CA_DIR/$DOMAIN.cert

cp $CA_DIR/$DOMAIN.cert /etc/docker/certs.d/$DOMAIN/
cp $CA_DIR/$DOMAIN.key /etc/docker/certs.d/$DOMAIN/
cp $CA_DIR/ca.crt /etc/docker/certs.d/$DOMAIN/

# enable for HTTP
touch /etc/docker/daemon.json
cat > /etc/docker/daemon.json <<EOF
{
  "insecure-registries":["$DOMAIN"]
}
EOF

systemctl daemon-reload
systemctl restart docker
