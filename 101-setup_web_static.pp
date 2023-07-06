file {
  '/data':
    ensure => 'directory',
    owner  => 'ubuntu',
    group  => 'ubuntu';

  '/data/web_static':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root';

  '/data/web_static/current':
    ensure => 'link',
    target => '/data/web_static/releases/test',
    owner  => 'root',
    group  => 'root',
    require => File['/data/web_static'];

  '/data/web_static/releases':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    require => File['/data/web_static'];

  '/data/web_static/shared':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    require => File['/data/web_static'];
  
  '/data/web_static/releases/test':
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    require => File['/data/web_static/releases'];
  
  '/data/web_static/current/index.html':
    ensure  => 'file',
    content => '<html>\n  <head>\n  </head>\n  <body>\n    Holberton School\n  </body>\n</html>',
    owner   => 'root',
    group   => 'root',
    require => File['/data/web_static/releases/test'];
}

service { 'nginx':
  ensure => 'running',
  enable => true,
  require => File['/data/web_static/current/index.html'];
}

