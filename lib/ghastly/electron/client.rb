require './lib/ghastly/electron'
require './lib/ghastly/electron/net/message'

require 'socket'
require 'thread'

class Ghastly::Electron::Client

  attr_accessor :user

  def initialize(user = "user")
    self.user = user
    @sender = nil
    @receiver = nil
  end

  def connect(host = Ghastly::Electron::Default::HOST, port = Ghastly::Electron::Default::PORT)
    
    # Create client socket
    @server = TCPSocket.new(host, port)

    start_listen_thread
    start_send_thread

    @receiver.join
    @sender.join
    
    @server.close
  rescue Errno::ECONNREFUSED
    $stdout.puts "Connection refused by the server."
  rescue Errno::ECONNRESET
    $stdout.puts "Connection closed by the server."
  end

  def start_listen_thread
    @receiver = Thread.new do
      loop do
        receive_message
      end
    end
  end

  def start_send_thread
    @sender = Thread.new do
      loop do
        send_message(prompt_and_read)
      end
    end
  end

  def prompt_and_read
    $stdout.print "#{user}> "
    read
  end

  def send(message)
    @server.puts message
  end

  def send_message(text)
    message = Ghastly::Electron::Net::Message.new(user, text)
    send message if message.valid?
  end

  def listen
    @server.gets.chomp
  end

  def receive_message
    message = Ghastly::Electron::Net::Message.parse(listen)
    puts "#{message.user}: #{message.content}" if message.valid?
  end

  def read
    text = $stdin.gets.chomp
    text
  end

  def puts(message)
    $stdout.puts message
  end
end