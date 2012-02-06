class nvidia::cuda::ubuntu (
  nvidia_module = undef
) {
  include package::virtual

  realize(
    Package["g++-4.3"],
    Package["g++-4.4"],
    Package["gcc-4.3"],
    package["gcc-4.4"],
    Package["libcr-dev"],
  )

  service {
    "nvidia-cuda":
      enable      => true,
      hasstatus   => true,
      subscribe   => [
        File["nvidia/cuda/rc.cuda"],
      ],
  }

  $nvidia = $nvidia_module ? {
    undef   => "nvidia-current",
    default => $nvidia_module,
  }

  file {
    "nvidia/cuda/rc.cuda":
      ensure  => file,
      path    => "/etc/init.d/nvidia-cuda",
      owner   => "0",
      group   => "0",
      mode    => "755",
      content => template("nvidia/rc.cuda.erb");
  }

}
