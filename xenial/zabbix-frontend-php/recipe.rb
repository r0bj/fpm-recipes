class ZabbixFrontendPhp < FPM::Cookery::Recipe
	homepage 'http://www.zabbix.com'
        source 'http://vorboss.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.0.4/zabbix-3.0.4.tar.gz'
        md5 'a164b27ef80221429fc9a39eab0b7b9c'

	name 'zabbix-frontend-php'
	version '1:3.0.4'
	revision '1'

	description 'network monitoring solution - PHP front-end
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
 This package provides a web-browsable front-end to the Zabbix server, which
 can display graphs of the data collected from clients.'

	post_uninstall 'postrm'

	depends 'libjs-jquery (>= 1.11.3+dfsg)',
		'libjs-jquery-ui (>= 1.10.1+dfsg)',
		'libjs-prototype (>= 1.7.1)',
		'ucf',
		'php',
		'php-gd',
		'php-pgsql | php-mysql | php-sqlite3',
		'ttf-dejavu-core'

	section 'net'
	maintainer 'Robert Jerzak <tapczan@unx.pl>'
	arch 'all'

	def build
	end

	def install
		etc('zabbix').mkdir
		share('zabbix').install Dir['frontends/php/*']
	end
end
