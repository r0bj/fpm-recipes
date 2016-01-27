# switch python_fix_name in /var/lib/gems/*/gems/fpm-cookery-*/lib/fpm/cookery/package to false

class PythonLxc < FPM::Cookery::PythonRecipe
	name 'lxc-python2'
	version '0.1'
	revision '2'
	description 'Linux container userspace tools (Python 2.x bindings)
 Containers are insulated areas inside a system, which have their own namespace
 for filesystem, network, PID, IPC, CPU and memory allocation and which can be
 created using the Control Group and Namespace features included in the Linux
 kernel.
 .
 This package contains the Python 2.x bindings.'
	maintainer 'Robert Jerzak <tapczan@unx.pl>'

	section 'python'

	build_depends 'python-dev',
		'lxc-dev'

	depends 'python (>= 2.7)',
		'python (<< 2.8)',
		'liblxc1'

	pre_uninstall 'prerm'
	post_install 'postinst'
end
