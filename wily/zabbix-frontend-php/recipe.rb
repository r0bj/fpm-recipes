class ZabbixFrontendPhp < FPM::Cookery::Recipe
	homepage 'http://www.zabbix.com'
        source 'http://vorboss.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/3.0.3/zabbix-3.0.3.tar.gz'
        md5 '7c45d37000e67d75042695344c9937e0'

	name 'zabbix-frontend-php'
	version '1:3.0.3'
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

	depends 'libjs-jquery-ui (>= 1.10.1+dfsg)',
		'libjs-prototype (>= 1.7.1)',
		'ucf',
		'apache2 | httpd',
		'php5',
		'php5-gd',
		'php5-pgsql | php5-mysql | php5-sqlite',
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
