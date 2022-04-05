class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if @application.pet_applications.all_approved?
      @application.update(status: "Approved")
      @application.pets.each do |pet|
        pet.update(adoptable: false)
      end
    elsif @application.pet_applications.all_inspected?
      @application.update(status: "Rejected")
    end
  end
end
