class ApplicationsController < ApplicationController
  def show
    @pets = session[:pets]
    @applicant = Application.find(params[:id])
  end

  def new 
  end

  def create 
    application = Application.new(application_params)
  require 'pry'; binding.pry

    if application.save
      redirect_to "/applications/#{application.id}" 
      require 'pry'; binding.pry
    else
      require 'pry'; binding.pry
      redirect_to "/applications/new"
      @errors = application.errors.messages

      flash[:alert] = @errors.map do |error|
        "#{error.first.capitalize} #{error.last}.".gsub(/[\["\]]/, "")
      end.join.gsub(/\./, ". ")
      require 'pry'; binding.pry
    end 
  end

  private 
  def application_params 
    params.permit(:name, :address, :city, :state, :zip_code,:description )
  end
end