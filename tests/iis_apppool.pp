iis_apppool {'Test':
  ensure => present,
}

iis_apppool {'Test2':
  ensure => absent,
}