class nvidia::cuda::ubuntu {
  include nvidia
  include ubuntu
  include package::virtual

  realize(
    Package["g++-4.3"],
    Package["g++-4.4"],
    Package["gcc-4.3"],
    Package["gcc-4.4"],
    Package["libcr-dev"],
  ) 

  service { "nvidia-cuda":
    enable    => true,
    hasstatus => true,
    require   => File["nvidia/cuda/rc.cuda"],
  }

  file { "nvidia/cuda/rc.cuda":
    ensure => file,
    path   => "/etc/init.d/nvidia-cuda",
    owner  => "0",
    group  => "0",
    mode   => "755",
    source => "puppet://$server/modules/nvidia/cuda/rc.cuda",
  }

  ubuntu::alternative { "/usr/bin/gcc-4.4":
    alternative => "gcc",
    priority    => "440",
    require     => Package["gcc-4.4"],
  }

}
