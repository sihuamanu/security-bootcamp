# security-bootcamp
DAY1
* asymmetric 

* hierarchy 
    * root CA
        * intermediate CA1     intermediate CA2
                * certs1                        certs2

* validity period

* template (computer template)

* increase entropy is important


Q: Is intermediate CA necessary?
A: No


DAY2
* SAML
    * single sign on web application
        * cm
        * nav
        * hue
* for Impala and Hiveserver2 , config both LDAP and Kerberos

* KDC time out

* At least on domain controller has configured LDAPS

* AD on AWS
    * directly to on-premise AD. 
        * latency
        * scale
        * Not recommend


Q: why not recommend to manage krb5.conf through cm?
A: for multi-domain, cm not know.



1. Problem:
    1. Caused by: javax.net.ssl.SSLHandshakeException: sun.security.validator.ValidatorException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
        1. need import the ldap server's certificate to the truststore (jssecacerts)
CM LDAP

KERBEROS


KERBEROS

HUE TLS


CM LDAP

HUE LDAP

[11:46 AM] Ben Spivey: needs to be the root CA for the domain controller cert
[11:46 AM] Ben Spivey: not the root ca you gener
[11:46 AM] Ben Spivey: did you add the ldap CA cert to truststore.pem



HIVE TLS

HIVE LDAPS




Validate Hive LDAP

beeline -u "jdbc:hive2://security-bootcamp-2.gce.cloudera.com:10000/default;ssl=true;sslTrustStore=/usr/java/jdk1.7.0_67-cloudera/jre/lib/security/jssecacerts" -n bootcamper2 -p 'Cloudera!’

or

beeline -u "jdbc:hive2://security-bootcamp-2.gce.cloudera.com:10000/default;ssl=true" -n bootcamper2 -p ‘Cloudera!’

Hive also can access with KERBEROS

beeline> !connect jdbc:hive2://security-bootcamp-2.gce.cloudera.com:10000/default;principal=hive/security-bootcamp-2.gce.cloudera.com@AD.SEC.CLOUDERA.COM;ssl=true
when enable LDAP for HIVE, HUE will meet some error, need do a workaround to move the HIVE authentication pattern back to kerberos. 

[11:48 AM] Ben Spivey: you need a safety valve for hive gateway
[11:48 AM] Ben Spivey: to set the authentication as kerberos
[11:48 AM] Ben Spivey: <property><name>hive.server2.authentication</name><value>kerberos</value></property>



IMPALA TLS LDAP







Connect to IMPALA-SHELL

