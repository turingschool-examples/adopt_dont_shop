# frozen_string_literal: true

class Petition < ApplicationRecord
  has_many :pet_petitions, dependent: :destroy
  has_many :pets, through: :pet_petitions
  validates :name, :street_address, :city, :state, :zipcode, presence: true

  def associated_pet_petitions
    pet_petitions.all
  end

end
