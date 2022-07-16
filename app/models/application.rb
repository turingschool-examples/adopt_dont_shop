class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications  


  def self.search(search)
    pets.where("name LIKE ?", search)
  end
  def status
    # logic that searches all pets on this application, 
    # And returns a status based on those pets status's
    return 'In Progress'
  end
end