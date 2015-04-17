require './lib/ghastly/electron/client'

require 'thor'

class Client < Thor

  desc "connect", "connects to a server"
  def connect(host = Ghastly::Electron::Default::HOST, port = Ghastly::Electron::Default::PORT)
    @client = Ghastly::Electron::Client.new
    @client.connect(host, port)
  rescue Ghastly::Electron::Client::ConnectionClosed, Ghastly::Electron::Client::ConnectionRefused => e
    puts e.message
  end
end

Client.start(ARGV)