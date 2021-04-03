class AdoptingApplication < ApplicationRecord
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
    binding.pry
    where(accepted: true)
  end

  def self.in_progress
    binding.pry
    where(in_progress: true)
  end

  def self.declined
    binding.pry
    where(declined: true)
  end

  def is_accepted
    
  end
end
