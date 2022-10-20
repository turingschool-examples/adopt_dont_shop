class VeterinaryOfficeVeterinariansController < ApplicationController
  def index
    @veterinary_office = VeterinaryOffice.find(params[:veterinary_office_id])

    if params[:sort] == 'alphabetical'
      @office_vets = @veterinary_office.alphabetical_vets
    elsif params[:review_rating]
      @office_vets = @veterinary_office.office_vets_filtered_by_rating(
        params[:review_rating]
      )
    else
      @office_vets = @veterinary_office.on_call_vets
    end
  end

  def new
    @vet_office = VeterinaryOffice.find_by(id: vet_params[:veterinary_office_id])
  end

  def create
    @vet_office = VeterinaryOffice.find(vet_params[:veterinary_office_id])
    veterinarian = Veterinarian.new(vet_params)

    if veterinarian.save
      redirect_to "/veterinary_offices/#{@vet_office.id}/veterinarians"
    else
      redirect_to "/veterinary_offices/#{@vet_office.id}/veterinarians/new"
      flash[:alert] = "Error: #{error_message(veterinarian.errors)}"
    end
  end
end