class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name,
                        :street_address,
                        :city,
                        :state,
                        :zipcode
  enum status: { "In Progress" => 0, "Pending" => 1, "Accepted" => 2, "Rejected" => 3 }

end
