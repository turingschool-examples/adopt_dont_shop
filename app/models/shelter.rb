class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :pet_applications, through: :pets

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

  def average_pet_age 
    pets.where('adoptable = ?', true).average(:age)
  end 

  def self.shelter_show(id)
    find_by_sql("SELECT id, name, address, city, zip FROM shelters WHERE id = #{id}")[0]
  end 

  def self.reverse_order
    find_by_sql("SELECT * FROM shelters ORDER BY shelters.name DESC")
  end

  def self.pending_apps
    joins(pets: :applications).where('applications.status = ?', "Pending")
  end

end
