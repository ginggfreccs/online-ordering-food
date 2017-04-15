class Restaurant < ApplicationRecord
	has_many :foods
	has_many :categories
	has_many :orders
	has_many :reviews
	has_many :opening_hours
	has_one :user 

	validates :name, :address, :city, :area, :estimated_delivery_time, presence: true

	has_attached_file :image, styles: { large: "600x600>", medium: "180x195>", thumb: "100x100#" }
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  	geocoded_by :full_street_address
  	after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  	def full_street_address
  		[area, address, city].join(', ')
	end
end
