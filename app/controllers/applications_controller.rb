class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    app = Application.create(app_params)

    if app.save
      app.update(status: "In Progress")
      redirect_to "/applications/#{app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(app.errors)}"
    end
  end

  private
    def app_params
      param_list = []

      param_list << :name unless params[:name] == ""
      param_list << :street_address unless params[:street_address] == ""
      param_list << :city unless params[:city] == ""
      param_list << :state unless params[:state] == ""
      param_list << :zip_code unless params[:zip_code] == ""
      param_list << :description unless params[:description] == ""

      params.permit(param_list)
    end
end
