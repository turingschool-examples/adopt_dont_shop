class Application < ApplicationRecord
    enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
    validates_presence_of :name
    validates_presence_of :street_address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :zipcode
    # validates_presence_of :description

    has_many :pet_applications
    has_many :pets, through: :pet_applications

    def adopt(pet)
        self.pets << pet
    end
end