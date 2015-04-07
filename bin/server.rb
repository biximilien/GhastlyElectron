# bin/server.rb

# include dependencies
require './config/environment'
require './lib/ghastly/electron/server'

# declare CLI
class Server < Thor

  # starts server
  desc "start", "starts server"
  def start
    threads = []
    
    Ghastly::Electron::Server.all.each do |server|
      threads << server.start
    end

    threads.each { |t| t.join }
  end

  # stops server
  desc "stop", "stops server"
  def stop
    Ghastly::Electron::Server.all.each { |server| server.stop }
  end

  # queries server status
  desc "status", "queries server status"
  def status
    Ghastly::Electron::Server.all.each { |server| server.status }
  end

end

Server.start(ARGV)