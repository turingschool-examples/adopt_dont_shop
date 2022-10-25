class PetApplication < ApplicationRecord 
  belongs_to :application
  belongs_to :pet

  def self.pets_based_on_application(reject, approve, application)
    where()
  end
end