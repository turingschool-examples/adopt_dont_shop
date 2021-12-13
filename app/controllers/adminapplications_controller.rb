class AdminapplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets =[]
    if params.include?(:pet_id)
      @pets << Pet.find(params[:pet_id])
    end

  end
end
