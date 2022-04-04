require 'rails_helper'

RSpec.describe 'the applications index' do
  it 'displays the applicant attributes ' do
    application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = application.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = application.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_3 = Pet.create(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to_not have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to_not have_content(pet_3.name)
    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it 'allows the user to search for pets' do
    application_1 = Application.create!(name: 'John', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = application_1.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = application_1.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_content(application.status)
    fill_in 'Search', with: 'Sparky'
    click_on 'Search'
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_content("Sparky")
  end

  it 'allows the user to adopt a pet' do
    application_1 = Application.create!(name: 'John', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = application_1.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = application_1.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{application.id}"
    fill_in 'Search', with: 'Sparky'
    click_on 'Search'
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_content("Sparky")
    click_on 'Adopt this pet'
    expect(current_path).to eq("/applications/#{application.id}")
    within "#pets" do
      expect(page).to have_content("Sparky")
    end
  end

#   As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
#
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
#
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application
 it 'allows the user to submit an application' do
   application_1 = Application.create!(name: 'John', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
   application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
   shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
   pet_1 = application_1.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
   pet_2 = application_1.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

   visit "/applications/#{application.id}"
   # save_and_open_page
   fill_in 'Search', with: 'Sparky'
   click_on 'Search'
   expect(current_path).to eq("/applications/#{application.id}")
   # save_and_open_page
   click_on 'Adopt this pet'
   expect(current_path).to eq("/applications/#{application.id}")
   save_and_open_page
   fill_in 'What makes you a good pet owner for these pet(s)?', with: 'Love dogs.'
   click_on 'Sumbit Application'
   expect(current_path).to eq("/applications/#{application.id}")
   expect(page).to have_content("Pending")
   expect(page).to_not have_content("Add a Pet to this Application")
   within "#pets" do
     expect(page).to have_content("Sparky")
   end
  end
end
