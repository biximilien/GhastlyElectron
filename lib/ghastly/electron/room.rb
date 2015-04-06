class Ghastly::Electron::Room < ActiveRecord::Base
  
  has_many :users

  def join(user)
    user.join(self)
  end

  def leave
    user.leave(self)
  end
end