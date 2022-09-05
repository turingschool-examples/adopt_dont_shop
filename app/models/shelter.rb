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

  def self.order_by_desc_alphabetically
    find_by_sql("SELECT shelters.* FROM shelters ORDER BY name desc")
  end

  def self.shelters_by_status
    joins(pets:[:applicants]).where({ "applicants.status" => 'Pending'}).distinct
    #     select shelters.name, pets.id, pets.name, applicants.first_name, applicants.id from shelters join pets on she
    # lters.id = pets.shelter_id join applicant_pets on pets.id = applicant_pets.pet_id join applicants on applicants.id = applicant_pets.applica
    # nt_id where applicants.status like 'Pending';
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
