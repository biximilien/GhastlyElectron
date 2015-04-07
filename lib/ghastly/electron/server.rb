require './lib/ghastly/electron'

require 'socket'

class Ghastly::Electron::Server < ActiveRecord::Base

  has_many :rooms

  def start

    @socket = TCPServer.new(host, port)
    update_attributes(running: true)

    Thread.new do
      while running?
        Thread.start(@socket.accept) do |client|
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
  end

  def stop
    update_attributes(running: false)
  end

  def status
    if running?
      puts "Ghastly Electron server #{id} running on #{host}:#{port}."
    else
      puts "Ghastly Electron server #{id} is not running."
    end
  end

end