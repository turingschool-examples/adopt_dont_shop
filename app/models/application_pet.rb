class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum status: { "Open" => "0", "Approved" => "1", "Rejected" => "2"}

  def self.app_pet(applicationid,petid)
    where("application_id = ? and pet_id = ?", applicationid, petid).first
  end
end
