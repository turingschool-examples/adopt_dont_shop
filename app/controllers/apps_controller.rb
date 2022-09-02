class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
    if !params[:query].blank?
      @results = search(params[:query])
    end
  end
end