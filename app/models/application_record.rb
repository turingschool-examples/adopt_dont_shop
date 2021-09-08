class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_for(search_params)
    where("name ILIKE ?", "%#{search_params}%")
  end
end
