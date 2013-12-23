exec { "nodejs-dependencies":
    command => "/usr/bin/apt-get install python g++ make"
}
exec { "nodejs-mkdir":
    command => "/bin/mkdir -p /var/src",
    require => Exec["nodejs-dependencies"],
    creates => "/var/src",
}
exec { "nodejs-download":
    command => "/usr/bin/wget -N http://nodejs.org/dist/node-latest.tar.gz",
    cwd     => "/var/src",
    require => Exec["nodejs-mkdir"],
    creates => "/var/src/node-latest.tar.gz",
}
exec { "nodejs-untar":
    command => "/bin/tar xzvf node-latest.tar.gz && cd node-v*",
    cwd     => "/var/src",
    require => Exec["nodejs-download"],
}
exec { "nodejs-configure":
    command  => "cd /var/src/node-v* && ./configure",
    provider => "shell",
    require  => Exec["nodejs-untar"],
}
exec { "nodejs-install":
    command  => "cd /var/src/node-v* && /usr/bin/make install",
    provider => "shell",
    require  => Exec["nodejs-configure"],
    timeout  => 0,
    creates  => "/usr/local/bin/node",
}

