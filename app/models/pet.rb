class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.name_includes(name)
    downcase_name = name.downcase
    where("name ILIKE ?", "%#{downcase_name}%")
  end
end
