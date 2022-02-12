class ApplicationsController < ApplicationController
  def show
    #binding.pry
    @app = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.new(app_params)
    app.save
    redirect_to "/applications/#{app.id}"
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
