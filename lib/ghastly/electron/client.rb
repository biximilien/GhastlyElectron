require './lib/ghastly/electron'

require 'socket'

class Ghastly::Electron::Client

  DEFAULT_HOST = 'localhost'
  DEFAULT_PORT = 25252

  def connect(host = DEFAULT_HOST, port = DEFAULT_PORT)
    @server = TCPSocket.new(host, port)

    while line = @server.gets
      puts line
    end

    @server.close
  end
end