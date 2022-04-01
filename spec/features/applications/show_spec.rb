require 'rails_helper'

RSpec.describe 'the applications show' do
	
	it 'shows application attributes' do 
		application = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd", 
										  city: "Denver", state: "CO", zipcode: "80123")
		shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
		pet_1 = shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
		visit "/applications/#{application.id}"

		expect(page).to have_content(application.name)
		expect(page).to have_content(application.street_address)
		expect(page).to have_content(application.city)
		expect(page).to have_content(application.state)
		expect(page).to have_content(application.zipcode)
		
	end




end