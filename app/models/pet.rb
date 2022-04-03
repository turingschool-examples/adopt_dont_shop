class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def self.search_by_name(input)
    find_by(name: "#{input}")
  end 

  # def self.search(search)
  #   if search
  #     pet_name = search.downcase
  #       if self.where(name: pet_name)
  #          self.where(name: pet_name).sort_by{|pet| pet.name}
  #       else
  #         puts "Sorry, no pets with that name are adoptable right now."
  #       end
  #   else
  #     puts "Sorry, no pets with that name are adoptable right now."
  #   end
  # end
end
