class Pet < ApplicationRecord
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def find_application_id
    # There can be multiple applications for a pet from a single shelter, this only takes the first
    pet_applications.pluck(:application_id).first
    
  end

  def self.match(search_name)
    formatted_name = search_name.downcase
    where("name ILIKE ?", "%#{formatted_name}%")
  end 

  def self.adoptable
    where(adoptable: true)
  end

  def self.approved_for_adoption
    where(adoptable: true).update(adoptable: false)
  end 
end
