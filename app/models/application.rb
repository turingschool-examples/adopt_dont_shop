class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :status, presence: true

  attribute :status, :string, default: "In Progress"
  attribute :description, :string, default: ""

  def update_status
    if description == "" || pets.empty?
      update({status: 'In Progress'})
    elsif description.length > 1 && !pets.empty?
      update({status: 'Pending'})
    end
  end
end
