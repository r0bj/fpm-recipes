class ZabbixFrontendPhp < FPM::Cookery::Recipe
	homepage 'http://www.zabbix.com'
	source 'http://cznic.dl.sourceforge.net/project/zabbix/ZABBIX%20Latest%20Stable/2.4.5/zabbix-2.4.5.tar.gz'
	md5 'a82eb0d55d3ca947e10a4a55238f4388'

	name 'zabbix-frontend-php'
	version '2.4.5'
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

	post_install 'postinst'
	post_uninstall 'postrm'

	depends	'ucf',
			'apache2 | httpd',
			'libiksemel3',
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
