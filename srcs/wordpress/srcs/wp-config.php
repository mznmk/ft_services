<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'database_name_here' );

/** MySQL database username */
define( 'DB_USER', 'username_here' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password_here' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         ':Mf$qB8*=|}M%Yi3s&?e6@A^>bk+HzGbx707}Dc,C]Y^:TheR}qcGcs60_*O:UAt');
define('SECURE_AUTH_KEY',  'JxwI5{5=sp>n{Zd_usr_J|JYm_2G11NKV,.~^J<}^>i+-b @]:B{_OQ0=p>/jaNm');
define('LOGGED_IN_KEY',    'rp|rj=ed:eVuO->.?p_4z|{JwDGd>/k{Ho86DljX=8P#2)y{jC<F%5ZUoeH]k=(}');
define('NONCE_KEY',        '?PF6tfw9CO|sC1_pZ46d)p;Y71CvJyU&j50i~/BD1|-wECqx`M, u)BvI&[>7JQi');
define('AUTH_SALT',        '#i7J]$|/%@o7GT!/97|8p n@;>L:tpJhG+T;Q)B.4DLcKY*8v^sx4xZLtl$:~=]0');
define('SECURE_AUTH_SALT', 'sTKR_@bB])7~1`-ztOkV_RxQ2-x7$(uG4))#(T.j%6>`5D@E(/s:y7/9 m~YW-4{');
define('LOGGED_IN_SALT',   'PwIdV}3&y.x*W*aq9]doKx?^|IDS*|>;*nv9>J1ld=G_{2|kkf%AYf,|Q&l+YPRV');
define('NONCE_SALT',       'h0R!n=u&~+g%bJ)HvD^kn4E=>U`ho]$t+/%Un?&3bB7n{r`w}HV]$ms{>_A/TlGl');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
