require './lib/ghastly/electron/client'

require 'thor'

class Client < Thor

  desc "connect", "connects to a server"
  def connect
    @client = Ghastly::Electron::Client.new
    @client.connect
  end
end

Client.start(ARGV)