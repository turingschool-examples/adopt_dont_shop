class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy

  def self.order_by_alph
    find_by_sql("SELECT *  FROM shelters ORDER BY name DESC")
  end

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
      #eriagjeoajg
  end

  def self.active_applications
      # joins(:applications).distinct.select("shelters.*")
      #.where("applications.status" => "Pending")
      joins(pets: [:applications]).where("status = ?", "Pending")
  end

  # def self.with_applications

  #   self.where ANY of pets(params[:application_id])

  #   # look through the pets of each shelter (pets)
  #   # iterate through pets, if param[:application_id] exists,
  #   # if true, end process and return shelter.name
  #   # if false, continue looking through pets
  # end

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
