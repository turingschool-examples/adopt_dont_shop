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

  def self.reverse_alphabetical_order 
    sql = "Select * FROM shelters ORDER BY shelters.name DESC" 
    find_by_sql(sql) 
  end 

  def self.shelters_with_pending_applications
    # shelter_ids is returning an array of shelter ids where the applications are pending. 
    # we then plug that variable "shelter_ids" into the next query to return those shelter objects
    # where will always return arrays.
    # Application queries should be in applocation model to follow single responsibility principal
    # check out application model to see the method "pending_shelter_ids"
    shelter_ids = Application.pending_shelter_ids
    Shelter.where(id: shelter_ids)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
