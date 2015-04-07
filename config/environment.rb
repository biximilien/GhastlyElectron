# environment.rb

# load rubygems
require 'rubygems'

# include dependencies
require 'thor'
require 'active_record'
require 'yaml'

# require local lib files
require './lib/ghastly'
require './lib/ghastly/electron'
require './lib/ghastly/electron/server'
require './lib/ghastly/electron/room'
require './lib/ghastly/electron/session'
require './lib/ghastly/electron/user'
require './lib/ghastly/electron/message'

# set application environment
GHASTLY_ELECTRON_ENV = ENV['GHASTLY_ELECTRON_ENV'] || 'development'

# load database configuration
config = YAML::load_file('config/database.yml')[GHASTLY_ELECTRON_ENV]

# establish connection
ActiveRecord::Base.establish_connection(config)