require 'rails_helper'

RSpec.describe 'application show' do
  let(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let(:application) { Application.create!(
                                    name: "Nate Brown",
                          street_address: "2000 35th Avenue",
                                    city: "Denver",
                                   state: "CO",
                                     zip: "90210",
                             description: "I have a big backyard",
                                  status: "In Progress"
                                         )}
  describe 'the application show page' do
    it 'shows the application and all its attributes (with links to pets)' do
      application.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
      application.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.full_address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.status)
      page.has_link?("Lobster")
      page.has_link?("Lucille Bald")
    end

    it 'renders the pet search' do
      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(find('form')).to have_content("Search for pet")
    end
  end

  describe 'the pet search' do
    context 'when valid data entered' do
      it 'searches for an existing pet and displays it on the show page' do
        pet = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Teddy', shelter_id: shelter.id)

        visit "/applications/#{application.id}"

        fill_in 'search', with: 'Teddy'
        click_button 'Submit'

        expect(page).to have_current_path("/applications/#{Application.last.id}?utf8=%E2%9C%93&search=Teddy&commit=Submit")
        expect(page).to have_content("Teddy")
      end
    end
    context 'when no data entered' do
      it 'returns to show page' do
        visit "/applications/#{application.id}"

        click_button 'Submit'
        expect(page).to have_current_path("/applications/#{Application.last.id}")
      end
    end
  end

#
# Submit an Application
#
# As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application

  context 'when the applicant has added pets' do
    it 'has a working submit application section' do
      pet = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Teddy', shelter_id: shelter.id)

      visit "/applications/#{application.id}"

      fill_in 'search', with: 'Teddy'
      click_button 'Submit'
      click_button "Adopt this Pet"

      expect(page).to have_current_path( "/applications/#{application.id}")
      expect(page).to have_content("Submit Application Section")

      fill_in 'description', with: 'I have a big backyard'

      expect(page).to_not have_content("Pending")

      click_button 'Submit Application'
      expect(page).to have_current_path( "/applications/#{application.id}")
      expect(page).to have_content("Pending")
      page.has_link?("Teddy")
      page.has_no_button?("search")
      expect(page).to_not have_content("Add a Pet to this Application")
    end
  end
  context 'when the applicant has not added pets' do
    it 'does not have a submit application section' do
      visit "/applications/#{application.id}"

      expect(page).to_not have_content("Submit Application")
    end
  end
end
