class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search_params)
    where("LOWER(name) ILIKE LOWER(?)", "%#{search_params}%")
  end
end
