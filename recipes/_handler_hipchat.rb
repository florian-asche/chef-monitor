#
# Cookbook Name:: monitor
# Recipe:: _handler_hipchat
#
# Copyright 2016, Philipp H
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
#

sensu_gem 'sensu-plugins-hipchat' do
  version '0.0.3'
end

include_recipe 'monitor::_filters'

sensu_snippet 'hipchat' do
  content(
    server_url: node['monitor']['hipchat_server_url'],
    apikey: node['monitor']['hipchat_apikey'],
    apiversion: node['monitor']['hipchat_apiversion'],
    room: node['monitor']['hipchat_room'],
    from: node['monitor']['hipchat_from']
  )
end

sensu_handler 'hipchat' do
  type 'pipe'
  command 'handler-hipchat.rb'
  filters ['occurrences']
  severities %w(warning critical)
  timeout node['monitor']['default_handler_timeout']
end