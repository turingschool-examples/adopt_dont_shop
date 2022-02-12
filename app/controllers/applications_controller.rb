class ApplicationsController < ApplicationController
  def show
    #binding.pry
    @app = Application.find(params[:id])
  end

  def create
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
