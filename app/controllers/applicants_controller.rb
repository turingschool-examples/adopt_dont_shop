class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pet_id_pairs = Pet.pluck(:id, :name)
  end
end