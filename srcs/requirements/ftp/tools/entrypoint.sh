#!/bin/bash
set -e

mkdir -p /var/run/vsftpd/empty

if ! grep -q "^${FTP_USER}:" /etc/passwd; then
	useradd -d /var/www/html -s /bin/bash "$FTP_USER"
fi
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd

chown -R "$FTP_USER":www-data /var/www/html
chmod -R 775 /var/www/html

exec vsftpd /etc/vsftpd.conf