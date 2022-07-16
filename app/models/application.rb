class Application < ApplicationRecord
  validates :name, presence: true 
  validates :street_address, presence: true 
  validates :city, presence: true 
  validates :state, presence: true 
  validates :zip_code, presence: true 

  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']

  # def check_fields?
  #   binding.pry 
  #   self.each do |key, value| 
  #     binding.pry 
  #   end
  # end
end
