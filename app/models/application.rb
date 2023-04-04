class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets, source: :pet
  validates_presence_of :name, 
                        :street_address, 
                        :city, 
                        :state, 
                        :zip_code, 
                        :description
  after_update :update_pets_adoptable_status

  def eligible?
    status == "In Progress" && !pets.empty?
  end

  def self.create_app(params)
    application = Application.new(params)
    if application.valid?
      application.save!
      application
    end
  end

  def update_pets_adoptable_status
    if self.status == "Approved"
      pets.update(adoptable: false)
    end
  end

end
