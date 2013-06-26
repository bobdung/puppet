# manage nginx webserver
class nginx {
	package { 'apache2.2-common':
		ensure => absent,
	}

	package { 'nginx':
		ensure => installed,
		require => Package['apache2.2-common'],
	}

	service { 'nginx':
		ensure => running,
		require => Package['nginx'],
	}

	file { '/etc/nginx/sites-enabled/default':
		source => 'puppet:///modules/nginx/cat-pictures.conf',
		notify => Service['nginx'],
	}

	file { '/var/www/cat-pictures':
		ensure => directory,
	}

	file { '/var/www/cat-pictures/index.html':
		source => 'puppet:///modules/nginx/index.html',
#		require => Package['/var/www/cat-pictures'],
	}

}

