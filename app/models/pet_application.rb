class PetApplication < ApplicationRecord
  after_initialize :set_default

  belongs_to :pet
  belongs_to :application

  def set_default
    self.status ||= "Pending"
  end

  def self.all_approved?
    !any?{|pet_app| pet_app.status != "Approved"}
  end
end
