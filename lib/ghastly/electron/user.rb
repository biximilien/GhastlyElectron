require 'bcrypt'

class Ghastly::Electron::User < ActiveRecord::Base
  include BCrypt



  ### Rooms

  has_and_belongs_to_many :rooms



  ### Messages

  has_many :messages



  ### Username

  validates :username, presence: true, uniqueness: true



  def join(room)
    rooms << room
    save!
  end

  def leave(room)
    rooms.delete(room)
    save!
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end