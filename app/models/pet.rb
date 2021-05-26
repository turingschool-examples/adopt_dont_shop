class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  has_many :application_pets
  has_many :applications, through: :application_pets
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(search)
    pets = Pet.arel_table
    where(pets[:name].matches("%#{search}%"))
  end

  def self.filter_by_pending_apps
    # joins(:application_pets, :applications).where("application_pets.application_id = applications.id AND applications.status")
    where(:id => ApplicationPet.filter_by_pending_apps).pluck(:shelter_id)
  end

  def application_status(app_id)
    if application_pets.where(pet_id: self.id, application_id: app_id, status: 'Approved').count > 0
      'Approved'
    elsif application_pets.where(pet_id: self.id, application_id: app_id, status: 'Rejected').count > 0
      'Rejected'
    else
      nil
    end
  end

  def approved_on_other_apps?(app_id)
    approved_apps = application_pets.where(pet_id: self.id, status: 'Approved').pluck(:application_id)
    other_approved_apps = Application.where.not(status: 'Rejected', id: app_id).where(:id => approved_apps)
    if !other_approved_apps.empty?
      return true
    end
  end

  def outstanding_apps
    outstanding_apps = applications.joins(:application_pets).where("applications.status = 'Pending' and application_pets.status is NULL").distinct
  end
end
