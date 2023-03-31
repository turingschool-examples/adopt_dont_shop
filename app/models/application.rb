class Application < ApplicationRecord

  def self.search_pet(name)
    Application.where(name_of_pet: name)
  end
end