class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true

  has_many :application_pets
  has_many :pets, through: :application_pets

  # def self.order_by_recently_created
  #   order(created_at: :desc)
  # end

  # def self.order_by_number_of_pets
  #   select("shelters.*, count(pets.id) AS pets_count")
  #     .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
  #     .group("shelters.id")
  #     .order("pets_count DESC")
  # end
  #
  # def pet_count
  #   pets.count
  # end
  #
  # def adoptable_pets
  #   pets.where(adoptable: true)
  # end
  #
  # def alphabetical_pets
  #   adoptable_pets.order(name: :asc)
  # end
  #
  # def shelter_pets_filtered_by_age(age_filter)
  #   adoptable_pets.where('age >= ?', age_filter)
  # end
end
