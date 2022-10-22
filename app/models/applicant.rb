class Applicant < ApplicationRecord 
  enum status: ["In Progress", "Pending", "Accepted", "Rejected" ]
  validates_presence_of :name, :street_address, :city, :state, :zip_code, :description, :status  

  has_many :pet_applicants 
  has_many :pets, through: :pet_applicants

  # def return_search 
  #   @applicant = Applicant.find(params[:id])
  #   @pets = Pet.all
  #   if params[:search].present?
  #     @pets = Pet.search(params[:search])
  #     redirect_to "/applicants/#{@applicant.id}"
  #   else
  #     @pets = Pet.adoptable
  #     # flash[:alert] = "Error: no pets found with that name. Here are the pets that are available!"
  #     # redirect_to "/pets"
  #   end
  # end
end