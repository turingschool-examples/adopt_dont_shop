class Application < ApplicationRecord
  validates :full_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true, numericality: true
  validates :description, presence: true

  belongs_to :pet

  def pet_name
    pet.name
  end

  def self.accepted
    where(accepted: true)
  end

  def self.in_progress
    where(in_progress: true)
  end

  def self.declined
    where(declined: true)
  end
end
