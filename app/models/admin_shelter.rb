class AdminShelter < ApplicationRecord

  def self.alphabetize_name
    find_by_sql("SELECT * FROM shelters ORDER BY name desc")
  end
end
