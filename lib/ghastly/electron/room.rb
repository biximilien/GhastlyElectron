class Ghastly::Electron::Room < ActiveRecord::Base

  belongs_to :server
  
  has_many :users

  def join(user)
    user.join(self)
  end

  def leave
    user.leave(self)
  end
end