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

  def self.nearby_items_by_cat(lat, long, id, distance = 50)
    users = User.near([lat, long], distance)
    items = users.map{|user| user.items}.flatten
    nearby_items = items.select{ |item|
      item.categories.pluck(:id).include? id
    }
  end

  def nearby_items_by_cat(id)
    items = nearby_items.select{ |item|
      item.categories.pluck(:id).include? id
    }
  end
  def nearby_items
    nearby_users.map{|user| user.items}.flatten
  end
  def nearby_users(distance = 50)
   User.near([self.latitude, self.longitude], distance).select{
    |user| user != self
   }

  end

  def address
  	[address1, city, zip_code].compact.join(' ')
  end
  def in_box
    sort_messages(inbound_messages)
  end
  def out_box
    sort_messages(outbound_messages)
  end
  def messages
    inbound_messages + outbound_messages
  end
  def unread_messages?
    inbound_messages.any?{|m| !m.is_read? }
  end
  def sort_messages(messages)
    messages.sort{|a,b|
      b.created_at <=> a.created_at
    }

  end
end
