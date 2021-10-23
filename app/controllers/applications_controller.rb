class ApplicationsController < ApplicationController
  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
      @application = load_application(params[:id])
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





  private
      def application_params
        params_hash = params.permit(
                      :name,
                      :street_address,
                      :city,
                      :state,
                      :zip
                      )
        params_hash[:status] = 'In Progress'
        params_hash
      end

      def load_application(id)
        Application.find(id)
      end
end
