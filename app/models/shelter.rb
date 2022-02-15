class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select('shelters.*, count(pets.id) AS pets_count')
      .joins('LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id')
      .group('shelters.id')
      .order('pets_count DESC')
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

  def self.reverse_alphabet
    sql = 'Select * FROM shelters ORDER BY shelters.name DESC'
    find_by_sql(sql)
  end

  def self.pending_apps
    shelters = Applicant.where(status: 'Pending').joins(:pets).pluck(:shelter_id).uniq
    find(shelters)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
