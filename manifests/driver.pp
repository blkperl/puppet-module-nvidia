class nvidia::driver {
  include package::virtual

  case $operatingsystem {
    "ubuntu": { realize(Package["nvidia-current"])              }
    default:  { err("nvidia does not support $operatingsystem") }
  }
}
