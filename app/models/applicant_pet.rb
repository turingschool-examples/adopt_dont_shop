# app/models/applicant_pet.rb
class ApplicantPet < ApplicationRecord
    belongs_to :applicant 
    belongs_to :pet
end
