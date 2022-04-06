class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @shelters_with_pending_applications = Shelter.pending
    @alpha_shelters_with_pending_applications = @shelters_with_pending_applications.order(:name)
  end

  def show
    id = params[:id]
    @shelter = Shelter.find_by_sql("SELECT name, city FROM shelters WHERE shelters.id = #{id}")
    @shelter_pets = Shelter.find_by_sql("SELECT age FROM pets WHERE shelter_id=#{id} AND adoptable=true")
    if @shelter_pets.count > 0
      @shelter_average_age = @shelter_pets.map {|pet|pet.age}.sum / @shelter_pets.count
    end
    @app_pets_nil = []
    Shelter.find(params[:id]).pets.each do |pet|
      pet.application_pets.each do |app_pet|
        if app_pet.pet_status == nil && app_pet.application.status == "Pending"
          @app_pets_nil << app_pet
        end
      end
    end
    
    @adopted_count = Pet.adopted
    # applications = Application.where(status: "Approved")
    # applications.each do |app|
    #   ApplicationPet.find
    # require 'pry'; binding.pry
  end
end
