class Pet < ApplicationRecord
  has_many :applicants, through: :applicant_pets, cache_counter: true
  
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
