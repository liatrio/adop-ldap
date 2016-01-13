FROM osixia/openldap:0.10.2

MAINTAINER Nick Griffin, <nicholas.griffin>

# Replicate all default environment variables from the base image and customize the needed one's. 
# This is to be able to use a custom entrypoint and perform all needed settings

ENV LDAP_ORGANISATION ADOP
ENV LDAP_DOMAIN adop.accenture.com
ENV LDAP_ADMIN_PASSWORD admin
ENV LDAP_CONFIG_PASSWORD config

#See table 5.1 in http://www.openldap.org/doc/admin24/slapdconf2.html for the available log levels.
ENV LDAP_LOG_LEVEL -1

ENV USE_TLS true
ENV SSL_CRT_FILENAME ldap.crt
ENV SSL_KEY_FILENAME ldap.key
ENV SSL_CA_CRT_FILENAME ca.crt

ENV USE_REPLICATION false
# variables $BASE_DN, $LDAP_ADMIN_PASSWORD, $LDAP_CONFIG_PASSWORD and $SSL_*
# are automaticaly replaced at run time

# if you want to add replication to an existing ldap
# adapt REPLICATION_CONFIG_SYNCPROV and REPLICATION_HDB_SYNCPROV to your configuration
# avoid using $BASE_DN, $LDAP_ADMIN_PASSWORD and $LDAP_CONFIG_PASSWORD variables
ENV REPLICATION_CONFIG_SYNCPROV 'binddn="cn=admin,cn=config" bindmethod=simple credentials=$LDAP_CONFIG_PASSWORD searchbase="cn=config" type=refreshAndPersist retry="5 5 300 5" timeout=1 starttls=critical'
ENV REPLICATION_HDB_SYNCPROV 'binddn="cn=admin,$BASE_DN" bindmethod=simple credentials=$LDAP_ADMIN_PASSWORD searchbase="$BASE_DN" type=refreshAndPersist interval=00:00:00:10 retry="5 5 300 5" timeout=1  starttls=critical'
ENV REPLICATION_HOSTS ldap://ldap.example.org,ldap://ldap2.example.org

# Cusatom environment variable

ENV LDAP_FULL_DOMAIN "dc=adop,dc=accenture,dc=com"
ENV LDAP_USER_DN "cn=admin,dc=adop,dc=accenture,dc=com"
ENV LDAP_PASSWORD "Sw4syJSWQRx2AK6KE3vbhpmL"
ENV LDAP_BASE_DN "dc=adop,dc=accenture,dc=com"
ENV LDAP_LDIFF "/tmp/structure.ldif"
ENV HOSTNAME "localhost"

# End environment variable definition

# Copy in configuration files
COPY resources/structure.ldif /tmp/
COPY resources/load_ldif.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*


ADD ./resources/entrypoint.sh /entrypoint.sh
RUN chmod 0777 /entrypoint.sh

ENTRYPOINT /entrypoint.sh $HOSTNAME $LDAP_USER_DN $LDAP_PASSWORD $LDAP_BASE_DN $LDAP_LDIFF