class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: { "Open" => "0", "Approved" => "1", "Rejected" => "2"}

  def self.pet_app(applicationid,petid)
    PetApplication.where("application_id = ? and pet_id = ?", applicationid, petid).first
  end
end
