class AdminShelter < ApplicationRecord
  def self.reverse_shelter
    Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
  end
end
