FROM osixia/openldap:0.10.2

MAINTAINER Nick Griffin, <nicholas.griffin>

# Copy in configuration files
COPY resources/structure.ldif /tmp/
COPY resources/load_ldif.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*

# Environment variables
ENV LDAP_ORGANISATION="ADOP" LDAP_DOMAIN="adop.accenture.com" LDAP_FULL_DOMAIN="dc=adop,dc=accenture,dc=com"