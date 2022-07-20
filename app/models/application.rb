class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates :name, presence: true
  validates :address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  def adopt_pets(params)
  	if params[:approve]
  		pets.find(params[:approve]).update(adoptable: false)
  		update(status: "Approved")
  	elsif params[:reject]
      pets.find(params[:reject]).update(adoptable: true)
      update(status: "Rejected")
  	end
  end

end
