class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :zip_code, length: { is: 5 }
  validates :zip_code, numericality: { greater_than_or_equal_to: 0 }

  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select('shelters.*, count(pets.id) AS pets_count')
      .joins('LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id')
      .group('shelters.id')
      .order('pets_count DESC')
  end

  def self.order_by_name_desc
    find_by_sql('SELECT * FROM shelters ORDER BY name DESC')
  end

  def self.order_by_name_asc
    Shelter.order(:name)
  end

  def self.shelters_with_pending_apps
    Shelter.select('shelters.*').distinct.joins(pets: :applications).where(applications: { status: 'In Progress' })
  end

  def self.find_shelter_raw(shelter_id)
    find_by_sql("SELECT * FROM shelters WHERE id='#{shelter_id}'").first
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

  def average_age
    adoptable_pets.average(:age)
  end
end
