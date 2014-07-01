#
# Cookbook Name:: smf-backbone
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "adarq" do
 home "/home/adarq"
 comment "www.adarq.org"
 shell "/bin/bash"
end

%w{finger php5 php5-fpm php-apc memcached}.each do |v|
 package v
end

mysql_service 'default' do
 version '5.6'
 server_root_password 'changeme'
end

web_app "adarq.org" do
  server_name "www.adarq.org"
  server_aliases ["adarq.org"]
  docroot "/home/adarq/public_html"
end
