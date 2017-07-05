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



commands = ["yum update -y", "yum install -y nginx", "chkconfig nginx on", "yum -y install php55 php55-fpm php55-bcmath php55-devel php55-common php55-cli php55-pecl-apc php55-pdo php55-mysql php55-xml php55-gd php55-mbstring php-pear php55-mysqlnd php55-mcrypt"]



commands.each do |comm|
    command comm
end
