class ApplicationsController < ApplicationController
  def show
    @application = load_application(params[:id])
  end

  def new
  end

  def create
    application = Application.create!(application_params)

    redirect_to "/applications/#{application.id}"
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
