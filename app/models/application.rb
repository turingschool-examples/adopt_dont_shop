class Application < ApplicationRecord
    enum status: {"In Progress": 0, "Pending": 1, "Accepted": 2, "Rejected": 3}
    validates_presence_of :name
    validates_presence_of :street_address
    validates_presence_of :city
    validates_presence_of :state
    validates_presence_of :zipcode
    # want to implement a callback 
    # validates_presence_of :description

    has_many :pet_applications
    has_many :pets, through: :pet_applications

    def adopt(pet)
        pets << pet
    end

    def self.application_requires_decision
        where(status: "Pending").joins(:pet_applications).where(pet_applications: {:status => nil})
    end 
end