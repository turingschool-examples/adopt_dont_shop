class ApplicationsController < ApplicationController

  def show
    #binding.pry
    @app = Application.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    end
  end

  def adoption
    app = Application.find(params[:id])
    #binding.pry
    pet = Pet.find(params[:pet_id])
    app.add_pet(pet)
    redirect_to "/applications/#{app.id}"
  end

  def new
  end

  def create
    app = Application.new(app_params)
    if app.save
      redirect_to "/applications/#{app.id}"
    else
      flash[:alert] = 'Fill out the form completely.'
      redirect_to "/applications/new"
    end
  end

  def update
    @app = Application.find(params[:id])
    @app.update(app_params)
    @app.save
    # binding.pry
    # @app.status_update
    redirect_to "/applications/#{@app.id}"
  end

  private
    def app_params
      params.permit(
        :name,
        :street,
        :city,
        :state,
        :zip,
        :description,
        :status
      )
    end

end
