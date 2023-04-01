class App < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  has_many :app_pets
  has_many :pets, through: :app_pets

  def apply_adopt(p_input_id)
    AppPet.create(app_id: id, pet_id: p_input_id)
  end
end