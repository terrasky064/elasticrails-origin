# Licensed to Spencer Peloquin under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Spencer Peloquin licenses this file to you under
# the MIT License (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   https://mit-license.org/
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Prevent `MyModel.inspect` failing with `ActiveRecord::ConnectionNotEstablished`
# (triggered by elasticsearch-model/lib/elasticsearch/model.rb:79:in `included')
#
ActiveRecord::Base.instance_eval do
  class << self
    def inspect_with_rescue
      inspect_without_rescue
    rescue ActiveRecord::ConnectionNotEstablished
      "#{self}(no database connection)"
    end

    alias_method_chain :inspect, :rescue
  end
end if defined?(ActiveRecord) && ActiveRecord::VERSION::STRING < '4'
