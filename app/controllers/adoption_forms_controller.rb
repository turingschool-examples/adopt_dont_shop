class AdoptionFormsController < ApplicationController
  def show
    @pet_form = AdoptionForm.find(params[:id])
  end
end
