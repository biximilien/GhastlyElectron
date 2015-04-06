# seed.rb

# include dependencies
require './config/environment'

require './lib/ghastly/electron'
require './lib/ghastly/electron/server'
require './lib/ghastly/electron/user'

# Create default server
Ghastly::Electron::Server.create(
  host: Ghastly::Electron::Default::HOST,
  port: Ghastly::Electron::Default::PORT
)

# Create default admin
Ghastly::Electron::User.create(
  username: 'admin',
  password: 'secret',
  admin: true
)