class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  # def
  #   @application_pet = ApplicationPet.find()
  # end
end
