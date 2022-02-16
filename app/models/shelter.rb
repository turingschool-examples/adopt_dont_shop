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

  def self.reverse_alphabetical_shelters
    sql = "Select * FROM shelters ORDER BY shelters.name DESC"
    find_by_sql(sql)
  end 

  def self.alphabetical_shelters_with_pending_apps
    shelter_ids = Application.where(status: "Pending").joins(:pets).pluck(:shelter_id).uniq
    where(id: shelter_ids).order(name: :asc)
  end

  def self.name_and_full_address(shelter)
    shelter = find_by_sql("SELECT name, street_address, city, state, zipcode FROM shelters WHERE id = #{shelter.id}")
    "Name: #{shelter.first.name}, Address: #{shelter.first.street_address} #{shelter.first.city}, #{shelter.first.state} #{shelter.first.zipcode}"
  end 

  def adoptable_pets_avg_age
    pets.where(adoptable: true).average(:age).round
  end 

  def adoptable_pet_count
    pets.where(adoptable: true).count
  end 
end
