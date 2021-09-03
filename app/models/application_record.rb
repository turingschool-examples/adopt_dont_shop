class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search(search_params)
    where("name iLIKE ?", "%#{search_params}%")
  end
end
