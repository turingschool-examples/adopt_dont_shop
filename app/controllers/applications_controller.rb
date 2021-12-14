class ApplicationsController < ApplicationController

  def show
    @application   = Application.find(params[:id])
    # @pets_to_adopt = Application.pets
  end

end
