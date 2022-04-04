class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :petapplications
  has_many :applications, through: :petapplications

  delegate :name, to: :shelter, prefix: true

  def self.adoptable
    where(adoptable: true)
  end

  def self.find_pet_by_name(name)
    where("name = ?", name)
  end
end
