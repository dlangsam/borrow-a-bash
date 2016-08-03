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

  def self.nearby_items_by_cat(id, coords, search_term, deposit, price, distance = 50)
    tempUser = User.new(latitude: coords[0], longitude: coords[1])
    items = tempUser.nearby_items_by_cat(id, coords, search_term, deposit, price, distance)
  end

  # refactor to use something lie this
   # ItemCategory.where(item_id: u.nearby_items.pluck(:id), category_id: 3).includes(:item).map(&:item).uniq
  def nearby_items_by_cat(id, coords, search, deposit, price, distance = 50)
    if coords != nil
      self.latitude = coords[0]
      self.longitude = coords[1]
    end
    if id != nil
      filtered_items = ItemCategory.where(item_id: self.nearby_items(distance).pluck(:id), category_id: id).includes(:item).map(&:item).uniq
    else
      filtered_items = self.nearby_items
    end
    if deposit != nil
      filtered_items = filtered_items.select do |item|
        puts item.name
          item.deposit <= deposit
      end
    end
   if price != nil
      filtered_items = filtered_items.select do |item|
        puts item.name
          item.price <= price
      end
    end
   if search != "" && search != nil
      filtered_items = filtered_items.select do |item|
        puts item.name
        item.name.downcase.include?(search.downcase)
      end
    end
    filtered_items 
  end
  def nearby_items(distance = 50)
    nearby_users(distance).map{|user| user.items.where(is_published: true)}.flatten
  end
  def nearby_users(distance = 50)
   User.where.not(id: self.id).includes(:items).near([self.latitude, self.longitude], distance)
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
