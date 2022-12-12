class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  has_many :application_pets
  has_many :pets, :through => :application_pets

  def pet_search(pet_name)
    Pet.where("name ILIKE ?", "%#{pet_name}%")
  end

  def has_pets?
    pets.count > 0
  end
  
  # def status_change
  #   app_status = Application.status
  #   if app_status == has_pets?
  # 
  # 
  #   # app_status = application_pets.map {|app| app.status}
  #   # if app_status.count < 1
  #   #   update_attribute(:status, "In Progress")
  #   # elsif
  #   #   (!app_status.include?("Pending")) && (!app_status.include?("Rejected"))
  #   #   update_attribute(:status, "Approved")
  #   # else
  #   #   update_attribute(:status, "Rejected")
  # 
  #   #if status == "in progress"
  #   #show the add pet
  # 
  #   #if status == "in progress" && pets > 0
  #   #show add pet and submit
  # 
  #   #if status == "pending"
  #   # don't show add pet or submit
  #   end
  # end
end