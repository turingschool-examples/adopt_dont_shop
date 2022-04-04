class Admin::SheltersController < ApplicationController

	def index
		@shelters = Shelter.order_by_name_alpha_reverse
	end 

end