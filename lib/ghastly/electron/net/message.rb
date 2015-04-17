require './lib/ghastly/electron/net'

require 'nokogiri'

class Ghastly::Electron::Net::Message
  attr_accessor :user, :content

  class << self
    def parse(message)
      new(
        user_from_message(message),
        content_from_message(message)
      )
    end

    private

      def user_from_message(message)
        # return nil if message.nil? || message.empty?
        user = Nokogiri::XML(message).xpath("//user").first
        # return nil if user.nil? || user.empty?
        user.content
      end

      def content_from_message(message)
        # return nil if message.nil? || message.empty?
        content = Nokogiri::XML(message).xpath("//content").first
        # return nil if content.nil? || content.empty?
        content.content
      end

  end

  def initialize(user, content)
    self.user = user
    self.content = content
  end

  def to_s
    "<message><user>#{user}</user><content>#{content}</content></message>"
  end

  def valid?
    !invalid?
  end

  def invalid?
    user.nil? && content.nil?
  end
end