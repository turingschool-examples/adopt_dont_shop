class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.find_by_name(name_input)
    name = arel_table[:name]
    where(name.matches("%#{name_input}%"))
  end
end
