class User < ApplicationRecord
  
  has_many :events, foreign_key: 'admin_id', class_name: "Event"
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  after_create :welcome_send
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
