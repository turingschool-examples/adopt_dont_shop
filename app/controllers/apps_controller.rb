class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
    @results = search(params[:query])
    if !params[:pet_id].blank?
      @new_pet = Pet.find(params[:pet_id])
      @app.adopt(@new_pet)
    end
  end

  def new
    if params[:errors].present?
      @errors = params[:errors]
    end
  end

  def create
    @app = App.create(app_params)
    if @app.save
      redirect_to "/apps/#{@app.id}"
    else
      @errors = @app.errors.full_messages.to_sentence
      redirect_to "/apps/new?errors=#{@errors}"
    end
  end

  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip_code, :description)
  end
end