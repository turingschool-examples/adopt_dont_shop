# frozen_string_literal: true

class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_petitions, dependent: :destroy
  has_many :petitions, through: :pet_petitions

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end
end
