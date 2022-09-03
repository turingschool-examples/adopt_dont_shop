class App < ApplicationRecord
  has_many :app_pets
  has_many :pets, through: :app_pets
  belongs_to :shelter
end

def search(query)
  if query != nil
    query.downcase!
    Pet.all.where("lower(name) LIKE :search", search: "%#{query}%")
  end
end

public
def adopt(pet)
  self.pets << pet
end