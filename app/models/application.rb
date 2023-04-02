class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name, :address,
                        :city, :state, :zip,
                        :description, :status

                        

  # def                      
  # search_term = params[:pet_name]
  # if search_term.present?
  #   @searched_pets = Pet.where("name LIKE ?", "%#{search_term}%")
  # else
  #   @searched_pets = []
  # end
                                              
end