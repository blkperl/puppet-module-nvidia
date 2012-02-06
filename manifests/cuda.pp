class nvidia::cuda (
  manage_driver = true,
  nvidia_module = undef
) {

  if $manage_driver { include nvidia::driver }

  case $operatingsystem {
    "ubuntu": {
      class {
        "nvidia::cuda::ubuntu":
          nvidia_module => $nvidia_module;
      }
    }
    default:  {
      err ("nvidia::cuda does not support $operatingsystem")
    }
  }
}
