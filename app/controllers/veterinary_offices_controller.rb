class VeterinaryOfficesController < ApplicationController
  def index
    if params[:sort].present? && params[:sort]== "veterinarian_count"
      @veterinary_offices = VeterinaryOffice.order_by_number_of_vets
    else
      @veterinary_offices = VeterinaryOffice.order_by_recently_created
    end
  end

  # def veterinarians
  #   @veterinary_office = VeterinaryOffice.find(params[:veterinary_office_id])

  #   if params[:sort] == 'alphabetical'
  #     @office_vets = @veterinary_office.alphabetical_vets
  #   elsif params[:review_rating]
  #     @office_vets = @veterinary_office.office_vets_filtered_by_rating(
  #       params[:review_rating]
  #     )
  #   else
  #     @office_vets = @veterinary_office.on_call_vets
  #   end
  # end

  def show
    @veterinary_office = VeterinaryOffice.find(params[:id])
  end

  def new
  end

  def create
    vet_office = VeterinaryOffice.new(vet_office_params)

    if vet_office.save
      redirect_to '/veterinary_offices'
    else
      redirect_to '/veterinary_offices/new'
      flash[:alert] = "Error: #{error_message(vet_office.errors)}"
    end
  end

  def edit
    @vet_office = VeterinaryOffice.find(params[:id])
  end

  def update
    vet_office = VeterinaryOffice.find(params[:id])
    if vet_office.update(vet_office_params)
      redirect_to '/veterinary_offices'
    else
      redirect_to "/veterinary_offices/#{vet_office.id}/edit"
      flash[:alert] = "Error: #{error_message(vet_office.errors)}"
    end
  end

  def destroy
    vet_office = VeterinaryOffice.find(params[:id])
    vet_office.destroy
    redirect_to '/veterinary_offices'
  end

  private

  def vet_office_params
    params.permit(:name, :max_patient_capacity, :boarding_services)
  end
end
