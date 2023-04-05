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

  def self.open_apps
    Shelter.joins(pets: :applications).where(applications: {status: "Pending"}).order("LOWER(shelters.name) ASC")
  end

  def self.reverse_alph
    self.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.find_name(tag)
    find_by_sql("SELECT name FROM shelters WHERE id=#{tag}").first[:name]
  end

  def self.find_address(tag)
    find_by_sql("SELECT CONCAT(street_address, ' ', city, ' ', state, ' ', zipcode) AS full_address FROM shelters WHERE id=#{tag}").first.full_address
  end

  def average_adoptable_pet_age
    pets.where(adoptable: :true).average(:age).to_f.round(2)
  end

  def adoptable_pet_count
    pets.where(adoptable: :true).count
  end
  
  def pending_pet_applications
    Pet.where(shelter_id: self.id).joins(:pet_applications).where(pet_applications: {condition: "Pending"}).distinct
  end
end
