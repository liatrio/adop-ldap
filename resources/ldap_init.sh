#!/bin/bash

set -e

LDAP_USER_DN=cn=admin,dc=adop,dc=accenture,dc=com
LDAP_PASSWORD=Sw4syJSWQRx2AK6KE3vbhpmL
LDAP_BASE_DN=dc=adop,dc=accenture,dc=com
LDAP_LDIFF="/tmp/structure.ldif"
HOSTNAME=$(cat /etc/hostname)

echo -e "Start polling for LDAP autoconfiguration [HOSTNAME: ${HOSTNAME}, LDAP_USER_DN ${LDAP_USER_DN}, LDAP_BASE_DN: ${LDAP_BASE_DN}, LDAP_LDIFF: ${LDAP_LDIFF}]"
nohup /usr/local/bin/load_ldif.sh -h ${HOSTNAME} -u ${LDAP_USER_DN} -p ${LDAP_PASSWORD} -b ${LDAP_BASE_DN} -f ${LDAP_LDIFF} &

exit 0