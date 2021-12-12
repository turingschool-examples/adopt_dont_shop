class SurveysController < ApplicationController 
  
  def index 
    @survey = Survey.all
  end

  def show 
    @survey = Survey.find(params[:id])
  end

  def new
  end

  def create 
    survey = Survey.new(survey_params)
    if survey.save
      redirect_to "/surveys/#{survey.id}"
    else 
      redirect_to "/surveys/new"
      flash[:alert] = "Error: #{error_message(survey.errors)}"
    end 
  end

  private 

  def survey_params 
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end