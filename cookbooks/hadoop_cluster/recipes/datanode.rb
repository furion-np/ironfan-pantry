#
# Cookbook Name::       hadoop_cluster
# Description::         Installs Hadoop Datanode service
# Recipe::              datanode
# Author::              Philip (flip) Kromer - Infochimps, Inc
#
# Copyright 2009, Opscode, Inc.
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

include_recipe 'hadoop_cluster'
include_recipe 'runit'

hadoop_service(:datanode)

announce(:hadoop, :datanode, {
           :logs => { :datanode => {
             :glob => node[:hadoop][:log_dir] + '/hadoop-hadoop-datanode-*.log'
           } },
           :ports => {
             :xcvr_port => { :port => node[:hadoop][:datanode][:xcvr_port] },
             :ipc_port  => { :port => node[:hadoop][:datanode][:ipc_port], }, 
             :dash_por  => { :port => node[:hadoop][:datanode][:dash_port], 
                             :dashboard => true}, 
           },
           :daemons => {
             :datanode => {
               :name => 'java',
               :user => node[:hadoop][:datanode][:user],
               :cmd  => 'hadoop-datanode'
             }
           }
         })

