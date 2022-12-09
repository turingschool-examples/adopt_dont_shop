class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
  def new

  end
  def create
    @application = Application.create!(first: params[:first], last: params[:last], street: params[:street], city: params[:city], state: params[:state], zip: params[:zip], description: params[:description], status: "Pending")
    redirect_to "/applications/#{@application.id}"
  end
end