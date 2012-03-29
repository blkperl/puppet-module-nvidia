class nvidia::params {

  case $operatingsystem {
    "ubuntu": {
      $ensure         = present
      $driver_package = 'nvidia-current'
      $nvidia_module  = 'nvidia-current'
    }
  }

}
