class nvidia::driver::ubuntu (
  ensure,
  driver_package
) {

  if defined(Class['nvidia::cuda::ubuntu']) {
    $package_before = Service['nvidia::cuda']
  } else {
    $package_before = undef
  }

  apt::ppa { 'ppa:ubuntu-x-swat/x-updates':
    before => Package['nvidia::driver'],
  }

  package { 'nvidia::driver':
    name   => $driver_package,
    ensure => $ensure,
    before => $package_before,
  }

}
