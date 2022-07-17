class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def self.order_by_name
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.apps_pending
    pets_with_pending_apps = Pet.joins(:application_pets).where(application_pets: {status: 1}).pluck(:id)
    
    @shelters = pets_with_pending_apps.flat_map do |pet_id| 
      Shelter.joins(:pets).where(pets: {id: pet_id})
    end
  end
end
