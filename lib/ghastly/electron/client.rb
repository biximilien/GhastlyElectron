require './lib/ghastly/electron'

require 'socket'

class Ghastly::Electron::Client

  def connect(host = Ghastly::Electron::Default::HOST, port = Ghastly::Electron::Default::PORT)
    
    @server = TCPSocket.new(host, port)

    while line = @server.gets
      puts line
    end

    @server.close
  end
end