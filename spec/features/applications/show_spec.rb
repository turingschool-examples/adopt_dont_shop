require 'rails_helper'

RSpec.describe 'the applications show' do
	before :each do
 		@application = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd",
										  city: "Denver", state: "CO", zipcode: 80123)
		@shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
		@pet_1 = @shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
	end

	it 'shows application attributes' do
		visit "/applications/#{@application.id}"

		expect(page).to have_content(@application.name)
		expect(page).to have_content(@application.street_address)
		expect(page).to have_content(@application.city)
		expect(page).to have_content(@application.state)
		expect(page).to have_content(@application.zipcode)

	end

	it 'has an area to search pet by name and can find a match' do
		visit "/applications/#{@application.id}"

		expect(page).to have_content("Add a Pet to this Application")

		fill_in "Search by name", with: "Dianne"
		click_button "Submit"

		expect(current_path).to eq("/applications/#{@application.id}")
		expect(page).to have_content(@pet_1.name)
		expect(page).to have_content(@pet_1.breed)

		visit "/applications/#{@application.id}"
		fill_in "Search by name", with: "Tino"
		click_button "Submit"

		expect(current_path).to eq("/applications/#{@application.id}")
		expect(page).to have_content("No pet by this name is found")
	end

	it 'can add pet to application' do
		visit "/applications/#{@application.id}"

		expect(page).to have_content("Add a Pet to this Application")

		fill_in "Search by name", with: "Dianne"
		click_button "Submit"
		click_button "Adopt #{@pet_1.name}"

		expect(current_path).to eq("/applications/#{@application.id}")

		within("#pets_selected") do
			expect(page).to have_content(@pet_1.name)
			expect(page).to have_content(@pet_1.breed)
			expect(page).to have_content(@pet_1.age)
		end

	end

	# it 'has an area to enter description and changes status on submittal' do
	# 	visit "/applications/#{@application.id}"
	# 	fill_in "Search by name", with: "Dianne"
	# 	click_button "Submit"
	#
	# 	expect(page).to have_content("Description")
	#
	# 	fill_in "Description", with: "I eat my vegetables"
	# 	click_button "Submit"
	#
	# 	expect(current_path).to eq("/applications/#{@application.id}")
	# 	expect(page).to have_content("Pending")
	#
	# end


end
