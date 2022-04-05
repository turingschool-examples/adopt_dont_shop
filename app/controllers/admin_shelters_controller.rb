class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
    @shelters_with_pending_applications = Shelter.pending
    @alpha_shelters_with_pending_applications = @shelters_with_pending_applications.order(:name)
  end

  def show
    id = params[:id]
    @shelter = Shelter.find_by_sql("SELECT name, city FROM shelters WHERE shelters.id = #{id}")
    @shelter_pets = Shelter.find_by_sql("SELECT age FROM pets WHERE shelter_id=#{id}")
    # @shelter_average_age = @shelter_pets.map {|pet|pet.age}.sum / @shelter_pets.count
  end
end
