class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  # def in_progress!
  #   update_attribute :status, "in progress"
  # end

  # def pending!
  #   update_attribute :status, "pending"
  # end

  # def accepted!
  #   update_attribute :status, "accepted"
  # end

  # def rejected!
  #   update_attribute :status, "rejected"
  # end
end