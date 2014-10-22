#
# Cookbook Name:: remaster
# Recipe:: dotfiles
#
# Copyright (C) 2014 TADOKORO Saneyuki
#
# MIT License
#

username = node[:remaster][:user]

{
  'root' => '/root',
  username => "/home/#{username}"
}.each do |name, home|
  homedir = "#{home}/dotfiles"

  git homedir do
    repository 'https://github.com/Saneyan/Dotfiles.git'
    revision   'master'
    action     :sync
    notifies   :run, 'script[setup_dmgr]', :immediately
  end

  script 'setup_dmgr' do
    interpreter 'zsh'
    user name
    code <<-EOH
      export HOME=#{home}
      cd #{homedir}
      ./setup.sh
      source common/zsh.d/.zprofile
      dmgr enable systemd pacman
      echo "The current dmgr status:"
      dmgr list
    EOH
  end

  directory homedir do
    owner name
    group name
    mode  '0755'
  end
end
