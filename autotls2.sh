for i in `cat /root/nodes`;do ssh $i "mkdir -p /opt/cloudera/security/x509; mkdir -p /opt/cloudera/security/jks;";done

for i in `cat /root/nodes`;do scp $i.jks $i:/opt/cloudera/security/jks;done

for i in `cat /root/nodes`;do scp $i.key $i.pem $i:/opt/cloudera/security/x509;done

for i in `cat /root/nodes`;do scp truststore.pem $i:/opt/cloudera/security/x509;done

for i in `cat /root/nodes`;do scp truststore.jks $i:/opt/cloudera/security/jks;done


for i in `cat /root/nodes`;do ssh $i "ln -s /opt/cloudera/security/x509/$i.key /opt/cloudera/security/x509/server.key";done
for i in `cat /root/nodes`;do ssh $i "ln -s /opt/cloudera/security/x509/$i.pem /opt/cloudera/security/x509/server.pem";done

for i in `cat /root/nodes`;do ssh $i "ln -s /opt/cloudera/security/jks/$i.jks /opt/cloudera/security/jks/server.jks";done
