class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zipcode
  enum status: { "In Progress" => "0", "Pending" => "1", "Approved" => "2", "Rejected" => "3" }

  def all_pets_approved
    self.pet_applications.all? { |pet_apps| pet_apps.status == "Approved" }
  end
end
