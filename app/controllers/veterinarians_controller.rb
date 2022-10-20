class VeterinariansController < ApplicationController
  def index
    @veterinarians = Veterinarian.on_call
  end

  def show
    @veterinarian = Veterinarian.find(params[:id])
  end

  def edit
    @veterinarian = Veterinarian.find(params[:id])
  end

  def update
    veterinarian = Veterinarian.find(params[:id])
    if veterinarian.update(vet_params)
      redirect_to "/veterinarians/#{veterinarian.id}"
    else
      redirect_to "/veterinarians/#{veterinarian.id}/edit"
      flash[:alert] = "Error: #{error_message(veterinarian.errors)}"
    end
  end

  def destroy
    Veterinarian.find(params[:id]).destroy
    redirect_to '/veterinarians'
  end

  private

  def vet_params
    params.permit(
      :id,
      :name,
      :on_call,
      :review_rating,
      :veterinary_office_id
    )
  end
end
