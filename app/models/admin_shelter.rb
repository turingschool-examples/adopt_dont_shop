class AdminShelter < ApplicationRecord
  def self.reverse_alphabetize
    order(name: :desc)
  end
end
