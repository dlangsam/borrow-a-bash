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

  def self.nearby_items_by_cat(id, coords, distance = 50)
    tempUser = User.new(latitude: coords[0], longitude: coords[1])
    items = tempUser.nearby_items_by_cat(id, coords, distance)
  end

  def nearby_items_by_cat(id, coords, distance = 50)
    if coords != nil
      self.latitude = coords[0]
      self.longitude = coords[1]
    end
    items = nearby_items(distance).select do |item| 
      item.categories.pluck(:id).include?(id) &&
      item.is_published?
    end

  end
  def nearby_items(distance = 50)
    nearby_users(distance).map{|user| user.items}.flatten
  end
  def nearby_users(distance = 50)
   User.near([self.latitude, self.longitude], distance).select{
    |user| user != self
   }
  end
  def get_zip_code
    zip_code
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
