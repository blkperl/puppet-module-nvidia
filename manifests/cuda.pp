class nvidia::cuda (
  nvidia_module = $nvidia::params::nvidia_module
) inherits nvidia::params {

  case $operatingsystem {
    "ubuntu": {
      class { "nvidia::cuda::ubuntu":
        nvidia_module => $nvidia_module,
      }
    }
    default: {
      fail("nvidia::cuda does not support $operatingsystem")
    }
  }

}
