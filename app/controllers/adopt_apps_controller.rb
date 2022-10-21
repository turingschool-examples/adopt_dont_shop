class AdoptAppsController < ApplicationController
  def show
    @adopt_app = AdoptApp.find(params[:id])
    @pets = @adopt_app.pets
    if params[:search_pets] != nil 
      @searched_pets = Pet.search(params[:search_pets]).adoptable
    end
  end

  def update 
    @adopt_app = AdoptApp.find(params[:id])
    if params[:pet_id] != nil 
      @pet = Pet.find(params[:pet_id])
      AdoptAppPet.create!(pet: @pet, adopt_app: @adopt_app)
    end
    redirect_to "/adopt_apps/#{@adopt_app.id}"
  end

  def create
    app = AdoptApp.create(app_params)

    redirect_to "/adopt_apps/#{app.id}"
  end

  private 
  def app_params
    params.permit(:id, :name, :street_address, :city, :state, :zip_code, :status)
  end


end
