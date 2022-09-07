class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :apps, dependent: :destroy

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_alpha
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.pending_apps
    joins(:apps).distinct.select("shelters.*").where("apps.status" => "Pending").order(:name)
  end

  def self.info(id)
    find_by_sql("select name, city from shelters where id = #{id}").first
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

  def average_pet_age
    pets.average(:age).round(2)
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def num_adoptable_pets
    adoptable_pets.count
  end

  def num_pets_adopted
    pets.where(adoptable: false).count
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end
end
