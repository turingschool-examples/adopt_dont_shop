class ApplicationsController < ApplicationController
  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
      @application = load_application(params[:id])
    elsif params[:search] == ""
      @pets = []
      @application = load_application(params[:id])

      redirect_to "/applications/#{@application.id}"
    else
      @pets = []
      @application = load_application(params[:id])
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def adopt
    application = load_application(params[:id])
    pet = load_pet(params[:pet_id])
    application.add_pet_to_application(pet)

    redirect_to "/applications/#{application.id}"
  end

  def update
    application = load_application(params[:id])
    if application.update(application_params)
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/#{application.id}/"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end


  private
      def application_params
        params_hash = params.permit(
                      :name,
                      :street_address,
                      :city,
                      :state,
                      :zip,
                      :description,
                      :status
                      )
        params_hash[:status] = 'In Progress'
        params_hash
      end

      def load_application(id)
        Application.find(id)
      end

      def load_pet(id)
        Pet.find(id)
      end
end
