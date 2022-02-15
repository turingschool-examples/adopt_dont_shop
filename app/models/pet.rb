class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  # write validations for this
  has_many :pet_adoption_forms
  has_many :adoption_forms, through: :pet_adoption_forms

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
