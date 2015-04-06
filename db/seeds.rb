# seed.rb

# include dependencies
require './config/environment'
require './lib/ghastly/electron/server'

# defaults
DEFAULT_HOST = 'localhost'
DEFAULT_PORT = 25252

# Create default server
Ghastly::Electron::Server.create(host: DEFAULT_HOST, port: DEFAULT_PORT)