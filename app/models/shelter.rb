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

  def self.reverse_alpha_names
    find_by_sql("SELECT * FROM shelters ORDER BY name desc")
  end

  def self.pending_apps
    joins(pets: :applications)
    .where("applications.status = ?", "Pending")
    .distinct
    .order(:name)
  end

  def self.name_and_city(shelter_id)
    find_by_sql ["SELECT name, city FROM shelters WHERE shelters.id = ?", shelter_id.to_i]
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

  def adoptable_pet_count
    adoptable_pets.count
  end


  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

end
