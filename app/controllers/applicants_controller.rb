class ApplicantsController < ApplicationController
  def new

  end

  def show
    @app = Applicant.find(params[:id])
  end
end
