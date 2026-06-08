#!/bin/bash
set -e

MAIL_USER="journalist"
MAIL_DOMAIN="arcturus-news.com"
MAIL_PASS="osint2025"
MAIL_FULL="${MAIL_USER}@${MAIL_DOMAIN}"
MAILDIR="/var/mail/vhosts/${MAIL_DOMAIN}/${MAIL_USER}"

echo "[init] Creating maildir structure..."
mkdir -p "${MAILDIR}/new"
mkdir -p "${MAILDIR}/cur"
mkdir -p "${MAILDIR}/tmp"
chown -R vmail:vmail "/var/mail/vhosts"
chmod -R 700 "/var/mail/vhosts"

echo "[init] Writing Dovecot passwd file..."
# Format: user@domain:{scheme}hash:uid:gid::/home::
HASH=$(doveadm pw -s SHA512-CRYPT -p "${MAIL_PASS}")
echo "${MAIL_FULL}:${HASH}:5000:5000::/var/mail/vhosts/${MAIL_DOMAIN}/${MAIL_USER}::" > /etc/dovecot/passwd
chmod 600 /etc/dovecot/passwd
chown dovecot:dovecot /etc/dovecot/passwd

echo "[init] Injecting whistleblower email into inbox..."
TIMESTAMP=$(date +%s)
FILENAME="${TIMESTAMP}.pid$$.lab"
cp /etc/mail/whistleblower.eml "${MAILDIR}/new/${FILENAME}"
chown vmail:vmail "${MAILDIR}/new/${FILENAME}"
chmod 600 "${MAILDIR}/new/${FILENAME}"

echo "[init] Initialising Roundcube database..."
php /var/lib/roundcube/bin/initdb.sh --dir=/var/lib/roundcube/SQL 2>/dev/null || true

echo "[init] Done. Starting services..."
exec /usr/bin/supervisord -c /etc/supervisord.conf