class Applicant < ApplicationRecord
    validates :name, presence: true
    validates :street_address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true 
    validates :good_fit, presence: true
    has_many :pet_applicants
    has_many :pets, through: :pet_applicants

    def add_pet(id)
        pets << Pet.find(id)
    end
end