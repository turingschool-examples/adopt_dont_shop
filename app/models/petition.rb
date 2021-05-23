# frozen_string_literal: true

class Petition < ApplicationRecord
  has_many :pet_petitions
  has_many :pets, through: :pet_petitions

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
end
