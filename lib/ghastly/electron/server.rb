require './lib/ghastly/electron'

require 'socket'

class Ghastly::Electron::Server < ActiveRecord::Base

  DEFAULT_HOST = 'localhost'
  DEFAULT_PORT = 25252

  has_many :rooms

  def start(host = DEFAULT_HOST, port = DEFAULT_PORT)
    @server = TCPServer.new(host, port)
    @running = true

    while @running
      Thread.start(@server.accept) do |client|
        client.puts "Ghastly Electron Server -- Welcome! -- #{Time.now}"
        while true
          # puts client.gets
          client.puts "DEBUG -- #{Time.now}"
          sleep 1.0
        end
        client.close
      end
    end
  end

  def stop
    @running = false
  end

end