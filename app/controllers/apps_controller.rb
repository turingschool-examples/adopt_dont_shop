class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
  end
end