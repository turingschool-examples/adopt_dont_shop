class PetApplicant < ApplicationRecord
  belongs_to :applicant
  belongs_to :pet

  def self.app_id
    require 'pry'; binding.pry
  end
end