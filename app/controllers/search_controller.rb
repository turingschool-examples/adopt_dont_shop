class SearchController < ApplicationController
  def index
    @query = Pet.ransack(params[:q])
    @pets = @query.result(distinct: true)
  end


end
