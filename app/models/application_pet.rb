class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def self.filter_by_pending_apps
    where(:application_id => Application.filter_by_pending).pluck(:pet_id)
  end

  def self.find_record(pet_id, app_id)
    id = where(application_id: app_id, pet_id: pet_id).pluck(:id)
    find(id).first
  end

  def self.rejected_pet_count_for_app(app_id)
    where(application_id: app_id, status: 'Rejected').count
  end

  def self.approved_pet_count_for_app(app_id)
    where(application_id: app_id, status: 'Approved').count
  end

  def self.total_pet_count_for_app(app_id)
    where(application_id: app_id).count
  end
end
