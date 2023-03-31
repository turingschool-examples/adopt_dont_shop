class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelters.all
    @pets = Pets.all
  end
end