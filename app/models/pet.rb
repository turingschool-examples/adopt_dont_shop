class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets, source: :application

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search(query)
    if query.present?
      where("name ILIKE ?", "%#{query}%")
    end
  end

  def pending?(application_id)
    app_pet(application_id).status == "Pending"
  end
  
  def approved?(application_id)
    app_pet(application_id).status == "Approved"
  end
  
  def rejected?(application_id)
    app_pet(application_id).status == "Rejected"
  end

  private

  def app_pet(application_id)
    application_pets.find_by(application_id: application_id)
  end
end
