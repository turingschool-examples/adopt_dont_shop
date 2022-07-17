class Application < ApplicationRecord
  validates :name, presence: true 
  validates :street_address, presence: true 
  validates :city, presence: true 
  validates :state, presence: true 
  validates :zip_code, presence: true 

  has_many :application_pets
  has_many :pets, through: :application_pets
  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']

  def update_ap_status
    app_pets = ApplicationPet.where("application_id = ?", self.id)
    
    app_pets.each do |app_pet| 
      app_pet.update(status: 'Pending')
    end
  end
end
