class aegir {

  package { 'aegir':
    ensure       => present,
    responsefile => 'files/aegir.preseed',
    require      => Class['aegir::dependencies'],
  }

  include apt

  apt::sources {'aegir.list':
    dir  => '/tmp/vagrant-puppet/modules-0/aegir/files',
    name => 'aegir',
  }

  class {'apt::key':
    dir     => 'files',
    url     => 'http://debian.aegirproject.org',
    require => Apt::Sources['aegir.list'],
#    creates => 'files/key.asc',
  }

  class {'apt::update':
    require => Class['apt::key'],
  }

  package {'drush-make':
    ensure  => present,
    require => [
      Class['aegir::sources'],
    ],
  }

  package {'mysql-server' :
    ensure       => present,
    responsefile => 'files/mysql-server.preseed',
  }

  package {'postfix' :
    ensure       => present,
    responsefile => 'files/postfix.preseed',
  }

}
