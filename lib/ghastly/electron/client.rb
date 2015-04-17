require './lib/ghastly/electron'
require './lib/ghastly/electron/net/message'

require 'socket'
require 'thread'
require 'logger'

class Ghastly::Electron::Client

  class ClientError < StandardError; end
  class ConnectionError < ClientError; end
  class ConnectionRefused < ConnectionError; end
  class ConnectionClosed < ConnectionError; end

  attr_accessor :user, :log

  def initialize(user = "user")
    self.user = user
    
    self.log = Logger.new(STDOUT)
    log.level = Logger::WARN

    @sender = nil
    @receiver = nil
  end

  def connect(host = Ghastly::Electron::Default::HOST, port = Ghastly::Electron::Default::PORT)
    log.info "Ghastly Electron Client v#{Ghastly::Electron::VERSION} is starting..."

    # Create client socket
    @server = TCPSocket.new(host, port)
    log.debug "Created socket #{@server}"

    start_listen_thread
    sleep 1.0
    start_send_thread

    @receiver.join
    @sender.join
    
    @server.close
  rescue Errno::ECONNREFUSED
    raise ConnectionRefused, "Connection refused by the server"
  rescue Errno::ECONNRESET
    raise ConnectionClosed, "Connection closed by the server"
  end

  def start_listen_thread
    log.debug "Started listening for messages"
    @receiver = Thread.new do
      loop do
        receive_message
      end
    end
  end

  def start_send_thread
    log.debug "Started sending messages"
    @sender = Thread.new do
      loop do
        send_message(prompt_and_read)
      end
    end
  end

  def prompt_and_read
    log.debug "Prompting user for chat message"
    $stdout.print "#{user}> "
    read
  end

  def send(message)
    log.debug "Sending message to server"
    @server.puts message
  end

  def send_message(text)
    log.debug "Building net message from text input by user"
    message = Ghastly::Electron::Net::Message.new(user, text)
    send message if message.valid?
  end

  def listen
    log.debug "Querying server for message"
    @server.gets.chomp
  end

  def receive_message
    log.debug "Building message from text received by server"
    message = Ghastly::Electron::Net::Message.parse(listen)
    puts "#{message.user}: #{message.content}" if message.valid?
  end

  def read
    log.debug "Reading text from the console"
    text = $stdin.gets.chomp
    text
  end

  def puts(message)
    log.debug "Outputs text to console"
    $stdout.puts message
  end
end