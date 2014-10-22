#
# Cookbook Name:: remaster
# Recipe:: default
#
# Copyright (C) 2014 TADOKORO Saneyuki
#
# MIT License
#

username = node[:remaster][:user]

user username do
  comment   username
  uid       100
  group     'wheel'
  home      "/home/#{username}"
  shell     '/bin/zsh'
  password  nil
  supports  :manage_home => true
  action    [ :create, :manage ]
end

remaster_configs '/etc/zsh/zlogin' do
  source    'zlogin.erb'
  variables({ :username => username })
end

remaster_configs '/etc/pacman.d/mirrorlist' do
  source    'mirrorlist.erb'
  variables({ :mirror_list => node[:remaster][:mirror_list] })
end

remaster_configs '/etc/pacman.conf' do
  source    'pacman.conf.erb'
end

remaster_configs '/etc/vconsole.conf' do
  source    'vconsole.conf.erb'
end

service 'sshd' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
