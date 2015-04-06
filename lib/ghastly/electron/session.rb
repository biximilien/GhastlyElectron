class Ghastly::Electron::Session < ActiveRecord::Base

  belongs_to :user

  validates :user, presence: true
  
end