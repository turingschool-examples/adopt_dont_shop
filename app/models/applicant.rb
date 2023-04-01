class Applicant < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :good_home, presence: true
  has_many :pet_applicants
  has_many :pets, through: :pet_applicants


  def self.search_name(name)
    require 'pry'; binding.pry
    pets.where("LOWER(name) LIKE '%#{name}%'")
  end
end