class nvidia::cuda {
  case $operatingsystem {
    "ubuntu": { include nvidia::cuda::ubuntu }
    default:  { err ("nvidia::cuda does not support $operatingsystem") }
  }
}
