class nvidia::driver (
  ensure         = $nvidia::params::ensure,
  driver_package = $nvidia::params::driver_package
) inherits nvidia::params {

  case $operatingsystem {
    "ubuntu": {
      class { "nvidia::driver::ubuntu":
        ensure         => $ensure,
        driver_package => $driver_package,
      }
    }
    default: {
      fail("nvidia::driver does not support $operatingsystem")
    }
  }

}
