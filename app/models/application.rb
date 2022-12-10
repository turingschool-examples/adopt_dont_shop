class Application < ApplicationRecord
  def address
    "#{street_address} #{city} #{state} #{zip_code}"
  end

  
end