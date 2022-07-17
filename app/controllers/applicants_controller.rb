class ApplicantsController < ApplicationController

  def show
    @applicant = Applicant.find(params[:id])
    @pet_search = Pet.search(params[:search]) if params[:search].present?
  end


end
