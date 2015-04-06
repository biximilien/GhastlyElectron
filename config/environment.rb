# environment.rb

# load rubygems
require 'rubygems'

# include dependencies
require 'thor'
require 'active_record'
require 'yaml'

# recursively requires all files in ./lib and down that end in .rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder +"/*.rb").each do |file|
    require file
  end
end

# set application environment
GHASTLY_ELECTRON_ENV = ENV['GHASTLY_ELECTRON_ENV'] || 'development'

# load database configuration
config = YAML::load_file('config/database.yml')[GHASTLY_ELECTRON_ENV]

# establish connection
ActiveRecord::Base.establish_connection(config)