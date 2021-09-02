class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search_params)
    where("name LIKE ?", "%#{search_params}%")
  end
end
