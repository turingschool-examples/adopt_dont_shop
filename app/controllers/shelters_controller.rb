class SheltersController < ApplicationController
  def index
    if params[:sort].present? && params[:sort] == "pet_count"
      @shelters = Shelter.order_by_number_of_pets
    elsif params[:search].present?
      @shelters = Shelter.search(params[:search])
    else
      # @shelters = Shelter.order_by_recently_created
      @shelters = Shelter.order_by_reverse_alpha
    end
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])

    if params[:sort] == 'alphabetical'
      @shelter_pets = @shelter.alphabetical_pets
    elsif params[:age]
      @shelter_pets = @shelter.shelter_pets_filtered_by_age(params[:age])
    else
      @shelter_pets = @shelter.adoptable_pets
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)

    if shelter.save
      redirect_to '/shelters'
    else
      redirect_to '/shelters/new'
      flash[:alert] = "Error: #{error_message(shelter.errors)}"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(shelter_params[:id])
    if shelter.update(shelter_params)
      redirect_to '/shelters'
    else
      redirect_to "/shelters/#{shelter.id}/edit"
      flash[:alert] = "Error: #{error_message(shelter.errors)}"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    shelter.destroy
    redirect_to '/shelters'
  end
  
  def admin_index
    @pending_app_shelters = Pet.pending_apps
  end

  def admin_show
    # @shelter = Shelter.find(params[:shelter_id])
    @search_shelter = Shelter.show_shelter(params[:shelter_id])
    @shelter = @search_shelter.first
    avg_age_adoptable_pets(params[:shelter_id])
    # binding.pry
  end

  # def admin_display
  #   search_shelter = Shelter.show_shelter(params[:shelter_id])
  #   @shelter_display = search_shelter.first
  # end


  def avg_age_adoptable_pets(param)
    shelter = Shelter.find(param)
    @avg_age = shelter.pets.avg_age
    @count_adoptable = shelter.pets.count_adoptable
  end

  private

  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end
end
