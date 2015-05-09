class ZabbixServerMysql < FPM::Cookery::Recipe
	homepage 'http://www.zabbix.com'
	source 'http://cznic.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.5/zabbix-2.4.5.tar.gz'
	md5 'a82eb0d55d3ca947e10a4a55238f4388'

	name 'zabbix-server-mysql'
	version '1:2.4.5'
	revision '1'

	description 'network monitoring solution - server (using MySQL)
 Zabbix is a server/client network monitoring system with many features.
 It can be used for:
 .
  - high level monitoring of IT services;
  - centralized monitoring of your servers and applications;
  - monitoring of SNMP-enabled devices;
  - performance monitoring (process load, network activity, disk
    activity, memory usage, OS parameters etc.);
  - data visualization.
 .
 This package provides the software needed to integrate a host as a Zabbix
 client. It collects information from Zabbix clients and stores it in a
 MySQL database.'

	config_files	'/etc/init.d/zabbix-server',
					'/etc/init/zabbix-server.conf',
					'/etc/default/zabbix-server',
					'/etc/logrotate.d/zabbix-server-mysql'

	pre_install 'preinst'
	pre_uninstall 'prerm'
	post_install 'postinst'
	post_uninstall 'postrm'

	conflicts	'zabbix-proxy-mysql',
				'zabbix-proxy-pgsql',
				'zabbix-proxy-sqlite3',
				'zabbix-server-pgsql',
				'zabbix-server-sqlite3'

	depends	'libc6 (>= 2.17)',
			'libcurl3-gnutls (>= 7.16.2)',
			'libiksemel3',
			'libldap-2.4-2 (>= 2.4.7)',
			'libmysqlclient18 (>= 5.5.13-1)',
			'libodbc1 (>= 2.2.11) | unixodbc (>= 2.2.11)',
			'libopenipmi0',
			'libsnmp30 (>= 5.7.2~dfsg)',
			'libssh2-1 (>= 1.0)',
			'libxml2 (>= 2.7.4)', 'sysv-rc (>= 2.88dsf-24) | file-rc (>= 0.8.16)', 'ucf', 'fping', 'adduser', 'lsb-base'

	section 'net'
	maintainer 'Robert Jerzak <tapczan@unx.pl>'

	def build
		configure	:datadir => '/etc',
					:sysconfdir => '/etc/zabbix',
					:prefix => '/usr',
					:infodir => '/usr/share/info',
					:mandir => '/usr/share/man',
					:enable_agent => true,
					:enable_proxy => true,
					:enable_server => true,
					:enable_ipv6 => true,
					:with_libcurl => true,
					:with_net_snmp => true,
					:with_ssh2 => true,
					:with_mysql => true,
					:with_openipmi => true,
					:with_ldap => true
		make
	end

	def install
		etc('zabbix/alert.d').mkdir
		var('log/zabbix-server').mkdir
		share('zabbix-server-mysql').mkdir

		bin.install 'src/zabbix_get/zabbix_get'
		sbin.install 'src/zabbix_server/zabbix_server'

		etc('init.d').install workdir('zabbix-server.init.d'), 'zabbix-server'
		etc('init').install workdir('zabbix-server.upstart'), 'zabbix-server.conf'
		etc('default').install workdir('zabbix-server.default'), 'zabbix-server'
		etc('logrotate.d').install workdir('zabbix-server-mysql.logrotate'), 'zabbix-server-mysql'

		man1.install 'man/zabbix_get.man'
		man8.install 'man/zabbix_server.man'

		safesystem 'gzip', man1('zabbix_get.man')
		safesystem 'gzip', man8('zabbix_server.man')

		share('zabbix-server-mysql').install 'database/mysql/data.sql'
		share('zabbix-server-mysql').install 'database/mysql/images.sql'
		share('zabbix-server-mysql').install 'database/mysql/schema.sql'
		share('zabbix-server-mysql').install workdir('zabbix_server.conf')

		safesystem 'gzip', share('zabbix-server-mysql/data.sql')
		safesystem 'gzip', share('zabbix-server-mysql/images.sql')
		safesystem 'gzip', share('zabbix-server-mysql/schema.sql')
	end
end
