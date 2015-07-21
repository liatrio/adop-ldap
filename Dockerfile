FROM osixia/openldap:0.10.2

MAINTAINER Nick Griffin, <nicholas.griffin>

# Copy in configuration files
COPY resources/structure.ldif /tmp/

# Environment variables
ENV LDAP_ORGANISATION="ADOP" LDAP_DOMAIN="adop.accenture.com" LDAP_FULL_DOMAIN="dc=adop,dc=accenture,dc=com"