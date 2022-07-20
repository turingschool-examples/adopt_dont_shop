class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  # def adopt_pets(params)
  #
  # 	if params[:approve]
  # 		pets.find(params[:approve]).update(adoptable: false)
  # 		update(status: "Approved")
  # 	elsif params[:reject]
  #   Application.find(params[:reject]).update_attributes(status: "Rejected")
  #   flash[:notice] = "Your application for this pet has been rejected."
  #    #pets.find(params[:reject]).update(adoptable: true)
  #    #update(status: "Rejected")
  # 	end
  # end
  def application_pending?(pet_id)
    application_status(pet_id) == "Pending"
  end

  def application_status(pet_id)
    pet_applications.find_by(pet_id: pet_id)&.status
  end

end
