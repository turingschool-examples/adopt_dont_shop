class Application < ApplicationRecord
  # belongs_to :pets

  def self.search_pet(name)
    Application.where(name_of_pet: name)
  end
end