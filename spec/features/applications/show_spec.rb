require 'rails_helper'

RSpec.describe 'the applications show' do
	
	it 'shows application attributes' do 
		application = Application.create!(name: "Tyler R", full_address:"1000 Something Blvd, Denver, 80221", 
										  description: "I'm lonely and need fluffy mammals")
		shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
		pet_1 = shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
		visit '/applications/show'
	end




end