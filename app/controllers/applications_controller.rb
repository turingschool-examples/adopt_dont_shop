class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    if params[:name] == ""
      params[:name] = nil
    end

    if params[:street_address] == ""
      params[:street_address] = nil
    end

    if params[:city] == ""
      params[:city] = nil
    end

    if params[:state] == ""
      params[:state] = nil
    end

    if params[:zip_code] == ""
      params[:zip_code] = nil
    end

    if params[:description] == ""
      params[:description] = nil
    end
    @application = Application.new(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
    )
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Application not saved: Please fill in missing fields."
      render :new
    end
  end
end
