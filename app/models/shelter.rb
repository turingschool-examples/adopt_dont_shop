class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_reverse_alphabetically
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
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

  def self.order_pending_alphabetically
    select("shelters.*")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .joins("INNER JOIN application_pets ON application_pets.pet_id = pets.id")
      .where("application_pets.state = 'Pending'")
      .group("shelters.id")
      .order("shelters.name")
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def average_adoptable_pet_age
    adoptable_pets.average(:age)
  end

  def adoptable_pet_count
    adoptable_pets.count
  end

  def adopted_pet_count
    applications = Application.where(status: 'Approved')
    count = 0
    pets.each do |pet|
      pet.applications.each do |application|
        if applications.include?(application)
          count += 1
        end
      end
    end
    count / 2
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def has_pending_applications?
    pets.any? do |pet|
      pet.has_pending_applications?
    end
  end
end
