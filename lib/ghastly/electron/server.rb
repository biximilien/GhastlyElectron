require './lib/ghastly/electron'
require './lib/ghastly/electron/net/message'

require 'socket'

class Ghastly::Electron::Server < ActiveRecord::Base

  attr_accessor :log

  has_many :rooms

  def start
    self.log = Logger.new(STDOUT)
    log.level = Logger::WARN

    @socket = TCPServer.new(host, port)
    @clients = []
    update(running: true)

    # Log start message
    log.info("Ghastly Electron Server v#{Ghastly::Electron::VERSION} is starting.")

    # Main loop
    loop do
      Thread.start(@socket.accept) do |client|
        # Add client to active clients list
        @clients << client
        
        # Display welcome message
        puts "#{client} has connected."
        client.puts Ghastly::Electron::Net::Message.new("server", "Ghastly Electron Server -- Welcome! -- #{Time.now}")
        
        # Main client loop
        loop do
          text = client.gets.chomp
          message = Ghastly::Electron::Net::Message.parse(text)
          if message.valid?
            log.debug "RECEIVED VALID MESSAGE"
            if command?(message.content)
              # log command and send command to handler
              log.debug "COMMAND #{message.content} RECEIVED from CLIENT #{client} with USER #{message.user}"
              handle_command(client, message.content)

            else
              # log debug message and display message in server console
              log.debug "MESSAGE #{message.content} RECEIVED from CLIENT #{client} with USER #{message.user}"
              $stdout.puts "#{message.user}: #{message.content}"

              # Relay message to all other clients
              (@clients - [client]).each do |c|
                log.debug "MESSAGE #{message.content} SENT to CLIENT #{c}"
                c.puts message
              end
            end
          else
            log.debug "RECEIVED INVALID MESSAGE"
          end
        end

        # Remove client from active clients and close socket
        # puts "#{client} has disconnected."
        # @clients.delete(client)
        client.close
      end
    end
  end

  def command?(message)
    return true if [:user, :passwd, :time, :quit, :exit].include? message.to_sym
    false
  end

  def handle_command(client, command)
    log.debug "RECEIVED COMMAND #{command}"
    case command
    when /quit/, /exit/
      puts "#{client} has disconnected."
      @clients.delete(client)
      client.close
    else
    end
  end

  def stop
    update(running: false)
  end

  def status
    if running?
      puts "Ghastly Electron server #{id} running on #{host}:#{port}."
    else
      puts "Ghastly Electron server #{id} is not running."
    end
  end

end