class ApplicationsController < ApplicationController

  def index
  end

  def show
    @application = Application.find(params[:application_id])
    @full_address = "#{@application.street_address} #{@application.city}, #{@application.state} #{@application.zip_code}"
  end

  def new
  end

  def create
    application = Application.new({
      name: params[:application][:name],
      street_address: params[:application][:street_address],
      city: params[:application][:city],
      state: params[:application][:state],
      zip_code: params[:application][:zip_code],
      created_at: params[:application][:created_at],
      updated_at: params[:application][:updated_at]
      })

    application.save

    redirect_to '/application'
  end
end