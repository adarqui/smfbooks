#
# Cookbook Name:: smf-backbone
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql::server'

user 'adarq' do
 home '/home/adarq'
 comment 'www.adarq.org'
 shell '/bin/bash'
end

directory '/home/adarq' do
 recursive true
end

%w{tcpdump finger php5 php5-fpm php-apc php5-mysql memcached}.each do |v|
 package v
end

mysql_service 'default' do
 version '5.5'
 server_root_password node['mysql']['server_root_password']
end

web_app 'adarq.org' do
  server_name node['smf_backbone']['server_name']
  server_aliases ['adarq.org']
  docroot '/home/adarq/public_html'
end

include_recipe 'database::mysql'

mysql_connection_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => node['mysql']['server_root_password']
}

%w{adarq_forum testing}.each do |v|
 mysql_database v do
  connection mysql_connection_info
  action :create
 end
 mysql_database_user v do
  connection mysql_connection_info
  database_name v
  password   node['mysql']['server_adarq_password']
  action     :grant
 end
end
