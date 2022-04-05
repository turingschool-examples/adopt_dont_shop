class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application


  def updated?
    status != nil
  end
end
