class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true
  validates :description, presence: true
  validates :status, presence: true

  attribute :description, :string, default: ""
  attribute :status, :string, default: "In progress"

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def update_status
    if description == "" || pets.empty?
      update({status: 'In progress'})
    elsif description.length > 1 && !pets.empty?
      update({status: 'Pending'})
    end 
  end

end
