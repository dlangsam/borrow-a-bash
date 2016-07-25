class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :items

  geocoded_by :address
  after_validation :geocode


  def address
  	[address1, city, zip_code].compact.join(' ')
  end
end
