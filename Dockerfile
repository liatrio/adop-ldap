FROM osixia/openldap:0.10.2

MAINTAINER Nick Griffin, <nicholas.griffin>

# Replicate all default environment variables from the base image and customize the needed one's. 
# This is to be able to use a custom entrypoint and perform all needed settings

ENV LDAP_ORGANISATION ADOP
ENV LDAP_DOMAIN adop.accenture.com
ENV LDAP_ADMIN_PASSWORD Sw4syJSWQRx2AK6KE3vbhpmL

# Cusatom environment variable

ENV LDAP_FULL_DOMAIN "dc=adop,dc=accenture,dc=com"

# End environment variable definition

# Copy in configuration files
COPY resources/structure.ldif /tmp/
COPY resources/load_ldif.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

ADD ./resources/ldap_init.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/ldap_init.sh