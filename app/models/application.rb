class Application < ApplicationRecord

  has_many :application_pets
  has_many :pets, through: :application_pets

  attribute:description, :string, default: ""
  attribute:status, :string, default: "In Progress"

  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true

  def has_pets?
    pets.present?
  end

  def in_progress?
    self.status == "In Progress"
  end

  def status_update
    if description.length > 1
      update({status: 'Pending'})
    end
  end
end
