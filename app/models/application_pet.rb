class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  has_one :shelter_id, through: :pets

  def nil?
   application_status == nil
  end
end
