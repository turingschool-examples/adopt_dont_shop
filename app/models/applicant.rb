class Applicant < ApplicationRecord 
    validates :name, presence: true
    validates :address, presence: true
    validates :description, presence: true
    validates :names_pets_wanted, presence: true
    validates :application_status, presence: true

    has_many :pets
end