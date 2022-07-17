class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true


  def self.search(search)
    pets.where("name ILIKE ?", search)
  end
  def status
    binding.pry
    if pet_applications.none? || description.nil?
      return 'In Progress'
    elsif pet_applications.where(status: 'Pending').any?
      return 'Pending'
    elsif pet_applications.where(status: 'Rejected').any?
      return 'Rejected'
    elsif pet_applications.where(status: 'Rejected').none? && pet_applications.where(status: 'Pending').none?
      return 'Approved'
    else
      return 'Error'
    end
  end
end