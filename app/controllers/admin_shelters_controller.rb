class AdminSheltersController < ApplicationController
  def index
    require 'pry'; binding.pry
    @shelters = Shelter.reverse_alphabetize
    # @shelters = Shelter.order(title: :desc)
  end
end