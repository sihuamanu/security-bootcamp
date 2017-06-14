for i in `cat nodes`;do ssh $i "yum install -y krb5-workstation sssd nscd samba";done

net ads join createupn=host/sihua-1.gce.cloudera.com@AD.SEC.CLOUDERA.COM createcomputer=ou=serviceaccounts,ou=secbootcamp,dc=ad,dc=sec,dc=cloudera,dc=com -S w2k8-1.ad.sec.cloudera.com -U bootcamper%Cloudera!

export LC_ALL="en_US.UTF-8"

authconfig --enablesssd --enablesssdauth --enablemkhomedir --update

service nscd start

service sssd restart


