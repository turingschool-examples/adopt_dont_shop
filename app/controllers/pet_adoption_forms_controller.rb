class PetAdoptionFormsController < ApplicationController
  def create
    connection = PetAdoptionForm.create({pet_id: params[:pet_id], adoption_form_id: params[:adoption_form_id]})
    redirect_to "/adoption_forms/#{params[:adoption_form_id]}"
  end
end
