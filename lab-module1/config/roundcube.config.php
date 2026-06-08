<?php
$config = [];

// IMAP — Dovecot running locally
$config['default_host'] = '127.0.0.1';
$config['default_port'] = 143;
$config['imap_conn_options'] = [
    'ssl' => ['verify_peer' => false, 'verify_peer_name' => false]
];

// Pass full email address as username to Dovecot
$config['username_domain'] = 'arcturus-news.com';

// SMTP — Postfix running locally
$config['smtp_server'] = '127.0.0.1';
$config['smtp_port'] = 25;
$config['smtp_user'] = '';
$config['smtp_pass'] = '';

// Branding
$config['product_name'] = 'Arcturus News — Secure Mail';
$config['support_url'] = '';
$config['skin'] = 'elastic';

// Auth
$config['enable_installer'] = false;

// Session key — must be exactly 24 chars
$config['des_key'] = 'osint_lab_secret_key_24c';

// SQLite DB for Roundcube internal use
$config['db_dsnw'] = 'sqlite:////var/roundcube/db/roundcube.db';

// ── Lab restrictions ─────────────────────────────────────────────────────────
// Show no headers in the message view
$config['show_headers'] = [];
// Lock so students cannot override via settings
$config['dont_override'] = ['show_headers'];