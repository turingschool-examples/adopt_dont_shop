class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :ShelterVeterinarians

  def self.order_alpha
    find_by_sql("SELECT shelters.* FROM shelters ORDER BY shelters.name desc")
  end

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

  def self.join_application_pending
    joins(pets: :applications).where("status = 'Pending'").pluck("name")
  end

  def self.get_name(id)
    Shelter.find_by_sql("SELECT name FROM shelters WHERE id = #{id}")
  end

  def self.get_city(id)
    Shelter.find_by_sql("SELECT city FROM shelters WHERE id = #{id}")
  end
end
