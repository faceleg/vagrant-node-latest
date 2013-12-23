package { "zsh":
  ensure => "latest"
}

exec { "omz-clone":
  command  => "git clone git://github.com/robbyrussell/oh-my-zsh.git /var/vagrant/.oh-my-zsh",
  provider => "shell",
  creates   => "/var/vagrant/.oh-my-zsh",
}

exec { "omz-config":
  command  => "cp /var/vagrant/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc",
  provider => "shell",
  require  => Exec["omz-clone"],
}

exec { "omz-chsh":
  command  => "chsh -s /bin/zsh",
  provider => "shell",
  require  => Exec["omz-config"],
}

