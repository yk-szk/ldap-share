FROM ubuntu
#FROM debian:buster

ARG DEBIAN_FRONTEND=noninteractive

ARG LDAP_BASE_DN
ARG LDAP_URI
ARG LDAP_ADMIN_ACCOUNT
ARG LDAP_ADMIN_PASSWORD
ARG LDAP_ORGANISATION

RUN apt-get update
RUN apt-get install -y --no-install-recommends samba smbldap-tools libpam-ldap nscd ldap-utils libnss-ldap

COPY smb.conf /etc/samba/smb.conf
COPY nsswitch.conf /etc/nsswitch.conf

COPY setup.sh /root/setup.sh
RUN bash /root/setup.sh

RUN echo $LDAP_ORGANISATION
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 139/tcp 445/tcp

ENTRYPOINT smbd -FS
