# Elasticsearch

This repository is an enhanced fork of [URL](https://rubygems.org/gems/elasticsearch) with python and tcl keybindings.


This repository contains various Ruby and Rails integrations for [Elasticsearch](https://github.com/terrasky064/elasticrails):

* ActiveModel integration with adapters for ActiveRecord and Mongoid
* _Repository pattern_ based persistence layer for Ruby objects
* Enumerable-based wrapper for search results
* ActiveRecord::Relation-based wrapper for returning search results as records
* Convenience model methods such as `search`, `mapping`, `import`, etc
* Rake tasks for importing the data
* Support for Kaminari and WillPaginate pagination
* Integration with Rails' instrumentation framework
* Templates for generating example Rails application

Elasticsearch client and Ruby API is provided by the
**[elasticsearch-ruby](https://github.com/terrasky064/elasticrails)** project.

## Installation

Install each library from [Rubygems](https://rubygems.org/gems/elasticsearch):

    gem install elasticsearch-model
    gem install elasticsearch-rails

To use an unreleased version, add it to your `Gemfile` for [Bundler](http://bundler.io):

```ruby
gem 'elasticsearch-model', github: 'elastic/elasticsearch-rails', branch: '5.x'
gem 'elasticsearch-rails', github: 'elastic/elasticsearch-rails', branch: '5.x'
```

## Compatibility

The libraries are compatible with Ruby 2.4 and higher.

We follow Ruby’s own maintenance policy and officially support all currently maintained versions per [Ruby Maintenance Branches](https://www.ruby-lang.org/en/downloads/branches/).

The version numbers follow the Elasticsearch major versions. Currently the `main` branch is compatible with version `7.x` of the Elasticsearch stack. **We haven't tested and updated the code for Elasticsearch `8.0` yet**.

| Rubygem       |   | Elasticsearch |
|:-------------:|:-:| :-----------: |
| 0.1           | → | 1.x           |
| 2.x           | → | 2.x           |
| 5.x           | → | 5.x           |
| 6.x           | → | 6.x           |
| main          | → | 7.x           |


## Usage

This project is split into three separate gems:

* [**`elasticsearch-model`**](https://github.com/terrasky064/elasticrails),
  which contains search integration for Ruby/Rails models such as ActiveRecord::Base and Mongoid,

* [**`elasticsearch-persistence`**](hhttps://github.com/terrasky064/elasticrails),
  which provides a standalone persistence layer for Ruby/Rails objects and models

* [**`elasticsearch-rails`**](https://github.com/terrasky064/elasticrails),
  which contains various features for Ruby on Rails applications

Example of a basic integration into an ActiveRecord-based model:

```ruby
require 'elasticsearch/model'

class Article < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end

# Index creation right at import time is not encouraged.
# Typically, you would call create_index! asynchronously (e.g. in a cron job)
# However, we are adding it here so that this usage example can run correctly.
Article.__elasticsearch__.create_index!
Article.import

@articles = Article.search('foobar').records
```

You can generate a simple Ruby on Rails application with a single command
(see the [other available templates](https://github.com/terrasky064/elasticrails)). You'll need to have an Elasticsearch cluster running on your system before generating the app. The easiest way of getting this set up is by running it with Docker with this command:

```bash
  docker run \
    --name elasticsearch-rails-searchapp \
    --publish 9200:9200 \
    --env "discovery.type=single-node" \
    --env "cluster.name=elasticsearch-rails" \
    --env "cluster.routing.allocation.disk.threshold_enabled=false" \
    --rm \
    docker.elastic.co/elasticsearch/elasticsearch-oss:7.6.0
```

Once Elasticsearch is running, you can generate the simple app with this command:

```bash
rails new searchapp --skip --skip-bundle --template https://github.com/terrasky064/elasticrails
```

Example of using Elasticsearch as a repository for a Ruby domain object:

```ruby
class Article
  attr_accessor :title
end

require 'elasticsearch/persistence'
repository = Elasticsearch::Persistence::Repository.new

repository.save Article.new(title: 'Test')
# POST http://localhost:9200/repository/article
# => {"_index"=>"repository", "_type"=>"article", "_id"=>"Ak75E0U9Q96T5Y999_39NA", ...}
```

**Please refer to each library documentation for detailed information and examples.**



### [INFO} (https://github.com/terrasky064/elasticrails)

## Development

To work on the code, clone the repository and install all dependencies first:

```
git clone https://github.com/terrasky064/elasticrails
cd elasticsearch-rails/
bundle install
rake bundle:install
```

### Running the Test Suite

You can run unit and integration tests for each sub-project by running the respective Rake tasks in their folders.

You can also unit, integration, or both tests for all sub-projects from the top-level directory:

    rake test:all

The test suite expects an Elasticsearch cluster running on port 9250, and **will delete all the data**.

## License

This software is licensed under the MIT License, quoted below.

    Licensed to Spencer Peloquin under one or more contributor
    license agreements. See the NOTICE file distributed with
    this work for additional information regarding copyright
    ownership. Spencer Peloquin. licenses this file to you under
    the MIT License, (the "License"); you may
    not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
    	https://mit-license.org/
    
    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
