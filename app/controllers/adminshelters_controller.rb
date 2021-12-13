class AdminsheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @applications = Application.pending
  end
end
