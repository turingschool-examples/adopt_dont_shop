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

  def self.order_by_name
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC;")
  end

  def pets_with_applications
    #find pets that have an application  
     require 'pry'; binding.pry
    # pets.where("pet_applications != nil")
    pets.where("pet_applications > 0")
  end

  # def pending_applications
  # Call pets_with_applications and find the ones where status == "Pending"
  # I want to filter all of the shelters so this should be a class method that is called 
  #in the index 
  # end
end
