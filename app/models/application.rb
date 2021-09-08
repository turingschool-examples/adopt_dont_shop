class Application < ApplicationRecord
  has_many :application_pets, dependent: :destroy
  has_many :pets, through: :application_pets
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def update_status!
    if all_approved? == true
      update({status: "Approved"})
    elsif all_approved? == false
      update({status: "Rejected"})
    end 
  end

  def all_approved?
    approved = ApplicationPet.where(status: 'Approved', application_id: id)
    pets.length > 0 && approved.length == pets.length
  end
end
