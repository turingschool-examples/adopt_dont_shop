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

  def self.order_by_reverse_alpha
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.show_list(id)
    find_by_sql("SELECT name, city FROM shelters WHERE id = #{id}")
  end

  def self.pending
    select("shelters.*")
    .joins(pets: :applications)
    .where("status = ?", 'Pending')
    .order(:name)
  end

  def pet_count
    pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def adoptable_aver_age
    pets = adoptable_pets
    pets.average(:age)
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
