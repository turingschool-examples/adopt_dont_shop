class ApplicationsController < ApplicationController

  def show
      @application = Application.find(params[:id])
  end

end
