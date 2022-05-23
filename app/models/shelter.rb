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

  def self.reverse_alphabetical
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end
  
  def self.with_pending_applications
    Shelter.joins(pets: :applications).where("applications.status = ?", 1).distinct
  end

  def self.make_city_readable(shelter_id)
    if find(shelter_id).city
      find_by_sql("SELECT id, city FROM shelters WHERE id=#{shelter_id}").first.city
    end
  end

  def self.make_name_readable(shelter_id)
    if find(shelter_id).name
      find_by_sql("SELECT id, name FROM shelters WHERE id=#{shelter_id}").first.name
    end
  end
  
  def average_pet_age
    pets.where(adoptable: :true).average(:age)
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
end
