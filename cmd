for i in `cat nodes`;do ssh $i "yum install -y krb5-workstation sssd nscd samba";done

net ads join createupn=host/sihua-1.gce.cloudera.com@AD.SEC.CLOUDERA.COM createcomputer=ou=serviceaccounts,ou=secbootcamp,dc=ad,dc=sec,dc=cloudera,dc=com -S w2k8-1.ad.sec.cloudera.com -U bootcamper%Cloudera!

export LC_ALL="en_US.UTF-8"

authconfig --enablesssd --enablesssdauth --enablemkhomedir --update

service nscd start

service sssd restart

curl -u admin:admin "https://security-bootcamp-1.gce.cloudera.com:7183/api/v13/cm/deployment" --cacert /opt/cloudera/security/x509/truststore.pem > cm-deployment.json

openssl s_client -verify 100 -showcerts -CAfile <(keytool -list -rfc -keystore /opt/cloudera/security/jks/truststore.jks -storepass <password>) -connect keytrustee_kms_host:16000
