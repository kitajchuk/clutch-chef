#
# Cookbook Name:: clutch
# Recipe:: setup
#
# Author:: Brandon Lee Kitajchuk <kitajchuk@gmail.com>
#
# Copyright 2017, Brandon Lee Kitajchuk.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.



node_version = "v10.16.3"
npm_version = "latest"
node_bin = "/usr/local/bin"



# Step 1.0: nginx install
commands = [
    "yum update -y",
    "yum install -y nginx",
    "chkconfig nginx on",
    "yum -y install php55 php55-fpm php55-bcmath php55-devel php55-common php55-cli php55-pecl-apc php55-pdo php55-mysql php55-xml php55-gd php55-mbstring php-pear php55-mysqlnd php55-mcrypt"
]

commands.each do |com|
    execute com do
        command com
    end
end



# nginx config
template "/etc/nginx/nginx.conf" do
    source "nginx.conf"
    action :create
end



# php-fpm config
replace_line "/etc/php-fpm.d/www.conf" do
    replace /^listen =.*$/
    with "listen = /var/run/php-fpm/php-fpm.sock"
end

replace_line "/etc/php-fpm.d/www.conf" do
    replace /^listen\.owner =.*$/
    with "listen.owner = nginx"
end

replace_line "/etc/php-fpm.d/www.conf" do
    replace /^listen\.group =.*$/
    with "listen.group = nginx"
end

replace_line "/etc/php-fpm.d/www.conf" do
    replace /^listen\.mode =.*$/
    with "listen.mode = 0664"
end

replace_line "/etc/php-fpm.d/www.conf" do
    replace /^user =.*$/
    with "user = nginx"
end

replace_line "/etc/php-fpm.d/www.conf" do
    replace /^group =.*$/
    with "group = nginx"
end



# php config
replace_line "/etc/php.ini" do
    replace /^error_log =.*$/
    with "error_log = /var/log/php-error.log"
end

replace_line "/etc/php.ini" do
    replace /^date\.timezone =.*$/
    with "date.timezone = \"UTC\""
end



# finalization
commands = [
    "chown -R root /var/www/html",
    "chmod -R 775 /var/www/html",
    "chkconfig nginx on",
    "service nginx start",
    "chkconfig php-fpm on",
    "service php-fpm start"
]

commands.each do |com|
    execute com do
        command com
    end
end



# node+npm install
commands = [
    "wget https://nodejs.org/dist/#{node_version}/node-#{node_version}-linux-x64.tar.xz",
    "tar xf node-#{node_version}-linux-x64.tar.xz",
    "mv /node-#{node_version}-linux-x64/bin/node /usr/local/bin/node",
    "mv /node-#{node_version}-linux-x64/bin/npm /usr/local/bin/npm",
    "mv /node-#{node_version}-linux-x64/lib/node_modules /usr/local/lib/node_modules",
    "rm -rf /node-#{node_version}-linux-x64.tar.xz",
    "rm -rf /node-#{node_version}-linux-x64",
    "npm install npm@#{npm_version} -g"
]

commands.each do |com|
    execute com do
        command com
    end
end

replace_line "/etc/sudoers" do
    replace /^Defaults .*secure_path = .*$/
    with "Defaults secure_path = /sbin:/bin:/usr/sbin:/usr/bin:#{node_bin}"
end



# End Clutch Chef setup!
