class ApplicantsController < ApplicationController

    def show
        @applicant = Applicant.find(params[:id])
    end
end