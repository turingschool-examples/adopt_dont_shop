class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @results = Pet.search(params[:name]) unless params[:name] == nil
  end

  def admin_show
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

  def submit
    app = Application.find(params[:id])

    app.update(app_params)
    app.update(status: "Pending")
    redirect_to "/applications/#{app.id}"
  end

  def complete
    app = Application.find(params[:id])
    app.update(status: app.status_check)
    if app.status == "Approved"
      redirect_to "/pets/adopt/#{app.id}"
    else
      redirect_to "/admin/applications/#{app.id}"
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
