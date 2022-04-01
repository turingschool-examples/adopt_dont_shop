require 'rails_helper'

RSpec.describe 'the applications new' do
	
	it 'creates a new application' do 
		shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
		pet_1 = shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
		visit "/pets/#{pet_1.id}"

		click_link "Start an Application"
		expect(current_path).to eq('/applications/new')

		fill_in "Name", with: "Kim G"
		fill_in "Street address", with: "123 Lowell St"
		fill_in "City", with: "Aurora"
		fill_in "State", with: "CO"
		fill_in "Zipcode", with: 80663

		click_button "Submit"

		expect(current_path).to eq("/applications/#{Application.first.id}")

		expect(page).to have_content("Kim G")
		expect(page).to have_content("123 Lowell St, Aurora, CO 80663")
	
	end




end