# bin/server.rb

# include dependencies
require './config/environment'
require './lib/ghastly/electron/server'

# declare CLI
class Server < Thor

  # starts server
  desc "start", "starts server"
  def start
    @server = Ghastly::Electron::Server.new
    @server.start
  end

  # stops server
  desc "stop", "stops server"
  def stop
    @server.stop
  end

  # queries server status
  desc "status", "queries server status"
  def status
    if @server
      puts "Server is running on #{host} port #{port}."
    else
      puts "Server is not running."
    end
  end

  private

    # shorthands
    
    def host
      @server.host
    end

    def port
      @server.port
    end

end

Server.start(ARGV)