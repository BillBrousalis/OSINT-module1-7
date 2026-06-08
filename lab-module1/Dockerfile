FROM debian:12-slim

# ── System packages ──────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    postfix \
    dovecot-core \
    dovecot-imapd \
    apache2 \
    libapache2-mod-php \
    php \
    php-mysql \
    php-sqlite3 \
    php-mbstring \
    php-xml \
    php-intl \
    php-zip \
    php-curl \
    roundcube \
    roundcube-sqlite3 \
    supervisor \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ── Create vmail user for Dovecot virtual mailboxes ──────────────────────────
RUN groupadd -g 5000 vmail && useradd -u 5000 -g vmail -s /sbin/nologin vmail

# ── Dovecot config ───────────────────────────────────────────────────────────
RUN mkdir -p /var/mail/vhosts/arcturus-news.com
COPY config/dovecot.conf /etc/dovecot/dovecot.conf

# ── Postfix config ───────────────────────────────────────────────────────────
COPY config/postfix-main.cf /etc/postfix/main.cf

# ── Roundcube config ─────────────────────────────────────────────────────────
COPY config/roundcube.config.php /etc/roundcube/config.inc.php
RUN mkdir -p /var/roundcube/db && chown www-data:www-data /var/roundcube/db

# ── Patch message.html — remove header toggle links at template level ─────────
RUN sed -i \
    -e '/<a href="#headers" class="headers-summary"/d' \
    -e '/<a href="#all-headers" class="headers-all"/d' \
    /usr/share/roundcube/skins/elastic/templates/message.html

# ── Apache config ────────────────────────────────────────────────────────────
COPY config/apache-roundcube.conf /etc/apache2/sites-available/roundcube.conf
RUN a2dissite 000-default && \
    a2ensite roundcube && \
    a2enmod rewrite php8.2

# ── Supervisord ──────────────────────────────────────────────────────────────
COPY config/supervisord.conf /etc/supervisord.conf

# ── Seed email ───────────────────────────────────────────────────────────────
COPY mail/whistleblower.eml /etc/mail/whistleblower.eml

# ── Entrypoint ───────────────────────────────────────────────────────────────
COPY init/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]