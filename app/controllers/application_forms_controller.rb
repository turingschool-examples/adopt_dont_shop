class ApplicationFormsController < ApplicationController

  def show
    @application_form = ApplicationForm.find(params[:id])
  end

end
