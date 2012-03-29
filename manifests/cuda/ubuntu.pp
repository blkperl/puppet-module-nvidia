class nvidia::cuda::ubuntu (
  nvidia_module = undef
) {
  include package::virtual

  realize(
    Package["g++-4.3"],
    Package["g++-4.4"],
    Package["gcc-4.3"],
    Package["gcc-4.4"],
    Package["libcr-dev"],
    Package["libglut3-dev"],
    Package["libxi-dev"],
    Package["libxmu-dev"],
  )

  apt::ppa { 'ppa:ubuntu-x-swat/x-updates': }

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
