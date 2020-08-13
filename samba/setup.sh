echo base $LDAP_BASE_DN
echo uri $LDAP_URI
echo rootbinddn $LDAP_ADMIN_ACCOUNT
echo rootpasswd $LDAP_ADMIN_PASSWORD


cat <<EOF > /etc/ldap.conf
base $LDAP_BASE_DN
uri $LDAP_URI
ldap_version 3
rootbinddn $LDAP_ADMIN_ACCOUNT
pam_password md5
EOF

echo $LDAP_ADMIN_PASSWORD > /etc/ldap.secret

echo "session required    pam_mkhomedir.so skel=/etc/skel umask=0022" >> /etc/pam.d/common-session
sed -i "s/use_authtok//g" /etc/pam.d/common-password

sed -i -e "s|LDAP_BASE_DN|$LDAP_BASE_DN|g" -e "s|LDAP_URI|$LDAP_URI|g" -e "s|LDAP_ADMIN_ACCOUNT|$LDAP_ADMIN_ACCOUNT|g" -e "s|LDAP_ORGANISATION|${LDAP_ORGANISATION^^}|g" /etc/samba/smb.conf

smbpasswd -w $LDAP_ADMIN_PASSWORD

for smbdir in /samba/public /samba/share /samba/users
do
    if [ ! -e ${smbdir} ]
    then
        mkdir -p ${smbdir}
    fi
done

/etc/init.d/nscd restart
#/etc/init.d/smbd restart
