<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'wordpress');

/** MySQL database username */
define('DB_USER', 'wordpress');

/** MySQL database password */
define('DB_PASSWORD', 'wordpress');

/** MySQL hostname */
define('DB_HOST', 'dbm.g1.foo');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '@-FgI;/Fl]5rsuaOx&7}y-Kb|}7: _1*a~rz6)b~-x,+v9c]9B;dpWVN4jLJctH0');
define('SECURE_AUTH_KEY',  '0ni<|7)md-f%qe>hImfmVv5e$%{#7c8zw{g]sL*n_%ar?|s |%0<,M;/{ME2r!*F');
define('LOGGED_IN_KEY',    '%D-8xA(+%K`.HGX]KGJgn_oO-i+uV|(|,{f4koEZ-Uc]`}9T.7X81B_b[P-V=!Mh');
define('NONCE_KEY',        '(_cylXty/Ab+TF:I}yeF:c7T=}[l$$$+9}Z<I|wBJsyin*:.wzBR1xg`|OyC2A-p');
define('AUTH_SALT',        '*A03C_(q1;W/Dv|<r--!Lfz-@KPK:G&|D_;:Cb*<UTB]hLgGqNE@<E/+QSgw<<^u');
define('SECURE_AUTH_SALT', 'e9opPwI&];pb+;UiUHH:,=Q|aK71oTa1![N^kY@<kYJ*LsT~YefJ}JJ2_<K4Cy,-');
define('LOGGED_IN_SALT',   'h9$[A%`#yx$4ahls;Z`S@a-(B!*a((v+lf_b(@kTUj;:V#QTGWJYCGfCUZ&)[{{G');
define('NONCE_SALT',       ':>/EQ*_c}smF WO:8/-i|$` 4~w}^#6l/#5}fDZ=9lsy(C1z54!zvzUZ~h?U->K ');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * WordPress Localized Language, defaults to English.
 *
 * Change this to localize WordPress. A corresponding MO file for the chosen
 * language must be installed to wp-content/languages. For example, install
 * de_DE.mo to wp-content/languages and set WPLANG to 'de_DE' to enable German
 * language support.
 */
define('WPLANG', '');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

