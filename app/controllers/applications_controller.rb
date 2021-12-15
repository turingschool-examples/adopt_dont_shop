class ApplicationsController < ApplicationController

  def show
    @applicant = Application.find(params[:id])
    @pets = @applicant.pets
  end

  def new
  end

  def create
  end

  # on view, have a link that says Start Application
  # <%=  link_to song.title, "/songs/#{song.id}" %>
  # when clicked, it takes to the application show.
  #

end
