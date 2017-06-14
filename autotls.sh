JAVA_HOME="/usr/java/jdk1.7.0_67-cloudera/bin"
nodes=`cat /root/nodes`
password="changeit"

openssl genrsa -aes256 -passout pass:${password} -out rootCA.key 4096
openssl req -new -x509 -key rootCA.key -passin pass:${password} -sha256 -days 3650 -out rootCA.pem -subj "/C=US/ST=CA/L=Palo Alto/O=Cloudera/OU=Dev Cluster/CN=Dev Cluster Certificate Authority" -extensions v3ext -config <(cat /etc/pki/tls/openssl.cnf <(
cat <<-EOF
[v3ext]
basicConstraints = critical,CA:TRUE, pathlen:1
keyUsage = critical, keyCertSign, cRLSign
EOF
))
$JAVA_HOME/keytool -importcert -file rootCA.pem -alias rootca -keystore truststore.jks -storepass ${password} -noprompt
cp rootCA.pem truststore.pem
/usr/java/jdk1.7.0_67-cloudera/bin/keytool -importcert -file rootCA.pem -alias rootca -keystore $JAVA_HOME/jre/lib/security/jssecacerts -storepass changeit -noprompt
for i in $nodes ;do
    openssl genrsa -aes256 -passout pass:${password} -out $i.key 4096
    openssl req -new -sha256 -passin pass:${password} -key $i.key -out $i.csr -subj "/C=US/ST=CA/L=Palo Alto/O=Cloudera/OU=Dev Cluster/CN=$i"
    openssl x509 -req -sha256 -extensions v3ext -in $i.csr -CA rootCA.pem -CAkey rootCA.key -passin pass:${password} -CAcreateserial -out $i.pem -days 365 -extfile <(
cat <<-EOF
[v3ext]
basicConstraints = critical, CA:FALSE
subjectAltName = DNS:$i
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
EOF
)
    openssl pkcs12 -export -in $i.pem -inkey $i.key -passin pass:${password} -out $i.p12 -passout pass:${password}
    $JAVA_HOME/keytool -importkeystore -destkeystore $i.jks -srckeystore $i.p12 -srcstoretype PKCS12 -srcstorepass ${password} -deststorepass ${password}
done
