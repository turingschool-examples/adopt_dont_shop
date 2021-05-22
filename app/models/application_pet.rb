class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.filter_by_pending_apps
    where(:application_id => Application.filter_by_pending).pluck(:pet_id)
  end
end
