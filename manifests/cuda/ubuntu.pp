class nvidia::cuda::ubuntu (
  nvidia_module = 'nvidia-current'
) {
  include package::virtual

  if defined(Class['nvidia::driver::ubuntu']) {
    $service_require = Package['nvidia::driver']
  } else {
    $service_require = undef
  }

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

  service { "nvidia::cuda":
    name      => 'nvidia-cuda',
    enable    => true,
    hasstatus => true,
    subscribe => File["nvidia/cuda/rc.cuda"],
    require   => $service_require
  }

  file { "nvidia/cuda/rc.cuda":
    ensure  => file,
    path    => "/etc/init.d/nvidia-cuda",
    owner   => "0",
    group   => "0",
    mode    => "755",
    content => template("nvidia/rc.cuda.erb");
  }

}
