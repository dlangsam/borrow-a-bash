class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :items
  has_many :inbound_messages, foreign_key: :recipient_id, class_name: "Message"
  has_many :outbound_messages, foreign_key: :sender_id, class_name: "Message"

  geocoded_by :address
  after_validation :geocode
  def nearby_items
    nearby_users.map{|user| user.items}.flatten
  end
  def nearby_users
    User.near([self.latitude, self.longitude], 50)
  end

  def address
  	[address1, city, zip_code].compact.join(' ')
  end
  def messages
    inbound_messages + outbound_messages
  end
end
