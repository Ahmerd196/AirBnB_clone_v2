file { '/tmp/':
  ensure => 'directory',
}

file { '/tmp/holberton':
  ensure  => 'file',
  content => "<html>\n  <head>\n  </head>\n  <body>\n    Holberton School\n  </body>\n</html>\n",
}

file { '/etc/puppet/':
  ensure => 'directory',
}

file { '/etc/puppet/holberton/':
  ensure => 'directory',
}

file { '/etc/puppet/holberton/holberton':
  ensure  => 'file',
  content => "User-agent: *\nDisallow: /",
}

package { 'nginx':
  ensure => 'installed',
}

service { 'nginx':
  ensure    => 'running',
  enable    => true,
  hasstatus => true,
  require   => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => 'file',
  content => "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server;\n\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n\t}\n\n\tlocation /redirect_me {\n\t\treturn 301 http://mydomain.tech/hbnb_static/index.html;\n\t}\n\n\terror_page 404 /custom_404.html;\n\tlocation = /custom_404.html {\n\t\troot /usr/share/nginx/html;\n\t\tinternal;\n\t}\n}",
  require => Package['nginx'],
  notify  => Service['nginx'],
}

file { '/data/':
  ensure => 'directory',
}

file { '/data/web_static/':
  ensure => 'directory',
}

file { '/data/web_static/releases/':
  ensure => 'directory',
}

file { '/data/web_static/shared/':
  ensure => 'directory',
}

file { '/data/web_static/releases/test/':
  ensure => 'directory',
}

file { '/data/web_static/current':
  ensure  => 'link',
  target  => '/data/web_static/releases/test',
  require => File['/data/web_static/releases/test/'],
}

file { '/data/web_static/releases/test/index.html':
  ensure  => 'file',
  content => "/tmp/holberton",
  require => File['/tmp/holberton'],
}

