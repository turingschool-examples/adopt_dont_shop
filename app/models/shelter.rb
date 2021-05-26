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

  def self.order_by_alphabetical
    find_by_sql("select * from shelters order by name desc;")
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

  def self.filter_by_pending_apps_ordered_alphabetically
    where(:id => Pet.filter_by_pending_apps).order(:name)
  end

  def average_pet_age
    pets.average(:age).round(2)
  end

  def num_adoptable_pets
    pets.where(adoptable: true).count
  end

  def num_adopted_pets
    pets.where(adoptable: false).count
  end

  def sql_name
    # This is so frustrating.
    # Even through my SQL returns the correct value,
    # the fact that the SQL is running over AR means the end result is an AR association.
    # So, in order to get my data out of an AR association,
    # I have to do another pluck which should have been handled by my select statement,
    # and then a first to get it out of the association
    # One, this is annoying, and two, im  not sure this meets the spec
    # If it doesnt, please help me understand what you're looing for
    sql = ("select name from shelters where id = #{self.id}")
    ActiveRecord::Base.connection.execute(sql)[0].values[0]
    # self.find_by_sql("select name from shelters where id = #{id}").pluck(:name).first
  end

  def sql_full_address
    sql = ("select concat(street_address,
                          ' ',
                          city,
                          ' ',
                          state,
                          ' ',
                          zip_code)
            from shelters
            where id = #{self.id}")
    ActiveRecord::Base.connection.execute(sql)[0].values[0]
  end

  def pets_needing_action
    pets_not_needing_action = pets.joins(:application_pets, :applications).where("application_pets.application_id = applications.id AND applications.status = 'Pending' and application_pets.status = 'Approved' AND adoptable = true").distinct.pluck(:id)
    pets_needing_action = pets.joins(:application_pets, :applications).where("application_pets.application_id = applications.id AND applications.status = 'Pending' and application_pets.status IS NULL = true AND adoptable = true").where.not(:id => pets_not_needing_action).distinct
  end
end
