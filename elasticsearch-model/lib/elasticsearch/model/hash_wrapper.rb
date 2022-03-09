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

module Elasticsearch
  module Model

    # Subclass of `Hashie::Mash` to wrap Hash-like structures
    # (responses from Elasticsearch, search definitions, etc)
    #
    # The primary goal of the subclass is to disable the
    # warning being printed by Hashie for re-defined
    # methods, such as `sort`.
    #
    class HashWrapper < ::Hashie::Mash
      disable_warnings if respond_to?(:disable_warnings)
    end
  end
end
