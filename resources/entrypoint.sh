#!/bin/bash

set -e

USER_DN=$2
#"cn=admin,dc=adop,dc=accenture,dc=com"
PASSWORD=$3
BASE_DN=$4
LDIFF=$5
HOSTNAME=$1

echo "Configure LDAP service"
/osixia/slapd/container-start.sh
echo "Start polling for LDAP autoconfiguration [LDAP_USER_DN: ${USER_DN}, LDAP_BASE_DN: ${BASE_DN}, LDAP_LDIFF ${LDIFF}]"
nohup /usr/local/bin/load_ldif.sh -h ${HOSTNAME} -u ${USER_DN} -p ${PASSWORD} -b ${BASE_DN} -f ${LDIFF} &
echo "Starting LDAP service"
/osixia/slapd/daemon.sh
echo "LDAP service started"