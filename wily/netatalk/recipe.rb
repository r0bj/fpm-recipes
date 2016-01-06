class Netatalk < FPM::Cookery::Recipe
	homepage 'http://netatalk.sourceforge.net'
	source 'http://skylink.dl.sourceforge.net/project/netatalk/netatalk/3.1.8/netatalk-3.1.8.tar.bz2'
	md5 '9cab934ca32b8979f389da52d44c69c2'

	name 'netatalk'
	version '3.1.8'
	revision '1'

	description "AppleTalk user binaries
 Netatalk is an implementation of the AppleTalk Protocol Suite for
 BSD-derived systems.  The current release contains support for
 EtherTalk Phase I and II, DDP, RTMP, NBP, ZIP, AEP, ATP, PAP, ASP, and
 AFP.
 .
 This package contains all daemon and utility programs as well as Netatalk's
 static libraries."

	depends	'libevent-2.0-5',
		'libavahi-client3',
		'libtdb1',
		'libmysqlclient18',
		'libtracker-sparql-1.0-0'

	section 'net'
	maintainer 'Robert Jerzak <tapczan@unx.pl>'

	def build
		configure	:prefix => '',
			:with_init_style => 'debian-systemd',
			:without_libevent => true,
			:without_tdb => true,
			:with_cracklib => true,
			:enable_krbV_uam => true,
			:with_pam_confdir => '/etc/pam.d',
			:with_dbus_sysconf_dir => '/etc/dbus-1/system.d',
			:with_tracker_pkgconfig_version => '1.0'
		make
	end

	def install
		make :install, 'DESTDIR' => destdir
	end
end
