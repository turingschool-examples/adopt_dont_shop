class AdminSheltersController < ApplicationController
   def index 
      @shelters = Shelter.reverse_alhpabetical
   end
end