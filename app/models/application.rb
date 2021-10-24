class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  def error_missing_field(params)
    if (params[:name] == nil) or (params[:street_address] == nil) or (params[:city] == nil) or (params[:state] == nil) or (params[:zip_code] == nil)
      return true
    end

  end
end
