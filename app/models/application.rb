class Application < ApplicationRecord
	after_initialize :default_values

	has_many :pet_applications
	has_many :pets, through: :pet_applications

	validates_presence_of :name, :street_address, :city, :state, :zip_code

	def default_values
		self.status ||= "In Progress"
	end

end
