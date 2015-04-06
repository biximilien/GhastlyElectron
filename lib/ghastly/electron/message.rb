class Ghastly::Electron::Message < ActiveRecord::Base



  ### Sender

  belongs_to :sender, class_name: 'User', foreign_key: 'sender_user_id'

  validates :sender, presence: true



  ### Receiver

  belongs_to :receiver, polymorphic: true

  validates :receiver, presence: true



  def to_s
    "#{content}"
  end

end