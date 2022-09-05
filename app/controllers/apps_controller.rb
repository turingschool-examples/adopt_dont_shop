class AppsController < ApplicationController
  def index
    @apps = App.all
  end
  
  def show
    @app = App.find(params[:id])
    if params[:pet_id].present?
      @new_pet = Pet.find(params[:pet_id])
      @app.adopt(@new_pet)
    elsif params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def admin_show
    @app = App.find(params[:id])
    @pets = @app.pets
    @pet_status = pet_status(params[:id], @pets)
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
    if params[:errors].present?
      @errors = params[:errors]
    end
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    @app = shelter.apps.create(app_params)
    if @app.save
      redirect_to "/apps/#{@app.id}"
    else
      @errors = @app.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/apps/new?shelter_id=#{shelter.id}&errors=#{@errors}"
    end
  end

  def update
    @app = App.find(params[:id])
    @app.update(
      {description: params[:description],
      status: params[:status]}
    )
    redirect_to "/apps/#{@app.id}"
  end

  private
  def app_params
    params.permit(:name, :address, :city, :zip_code, :description)
  end
end