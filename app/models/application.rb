class Application < ApplicationRecord
	after_initialize :default_values
	
	has_many :pet_applications
	has_many :pets, through: :pet_applications

	validates :name, presence: :true
	validates :street_address, presence: :true
	validates :city, presence: :true
	validates :state, presence: :true
	validates :zip_code, presence: :true
	# validates :description, presence: :true not sure we really need to validate this

	def default_values
		self.status ||= "In Progress"
	end

end
