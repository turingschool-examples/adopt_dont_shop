class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def self.pending_applications
    where(:status == "Pending")
  end

  def in_progress?
    status == "In Progress"
  end
end
