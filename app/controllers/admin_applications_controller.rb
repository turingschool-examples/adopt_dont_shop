class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # if params[:approve_pet]
    #   # @application.approved_pets(params[:approve_pet])
    #   # @application.pets.delete(params[:approve_pet])
    # end
  end

end
