class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def update_status!
    if all_approved?
      update({status: "Approved"})
    end
  end

  def all_approved?
    approved = ApplicationPet.where(status: 'Approved', application_id: id)
    approved.length == pets.length
  end
end
