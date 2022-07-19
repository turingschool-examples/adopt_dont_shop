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

  def self.order_by_reverse_alphabetical_by_name
    find_by_sql("
      SELECT * FROM shelters 
      ORDER BY shelters.name DESC;")
  end

  def self.filter_by_pets_with_pending_applications_alphabetically
    select("shelters.*")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .joins("LEFT OUTER JOIN pet_applications ON pets.id = pet_applications.pet_id")
      .where("pet_applications.status = 'Pending'")
      .order("shelters.name")
      .distinct
  end
  def pets_pending 
    pets.select("pets.* ")
      .joins("LEFT OUTER JOIN pet_applications ON pets.id = pet_applications.pet_id")
      .where("pet_applications.status = 'Pending'")
      .order("pets.name")
      .distinct
      
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
