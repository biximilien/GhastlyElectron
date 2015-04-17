require './lib/ghastly/electron/client'

require 'thor'

class Client < Thor

  desc "connect", "connects to a server"
  def connect(host = Ghastly::Electron::Default::HOST, port = Ghastly::Electron::Default::PORT)
    @client = Ghastly::Electron::Client.new
    @client.connect(host, port)
  end
end

Client.start(ARGV)