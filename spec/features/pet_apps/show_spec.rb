require 'rails_helper'

RSpec.describe 'the pet_apps show page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @app = App.create(name: 'Scooby', street: "123", city:"fake", state: "fake", zip: 48248)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    visit "/pet_apps/#{app.id}"
  end

  # Story 4
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search
  it 'when app not submitted, has a section to add a pet. Search for the pet and when fill in and submit, the pet is added' do
    expect(page).to have_button("Animals to choose from")
    expect(page).to have_button("Adopt #{@pet_3.name}")
  end

  # Story 5
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application
  it 'has a button for searched pet to add to adoption. Once clicked, returns to app with pet added' do
    find("button#{@pet1.name}").click
    expect(current_path).to eq("/pet_apps/#{app.id}")
    within("div#pets_on_app") do
      expect(page).to have_content(@pet1.name)
    end
  end

  # Story 6
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
  it 'Only once a pet is on app, there is a submit button and an input for good pet reasoning' do
    expect(page).to_not have_button('commit')
    expect(page).to_not have_content('Reasons for adopting:')
    find("button#{@pet1.name}").click
    expect(page).to have_button('commit')
    expect(page).to have_content('Reasons for adopting:')
  end

  it 'Once submitted, taken back to app, which now shows pending (in progress before)' do
    within('div#progress') do
      expect(page).to have_content('In Progress')
    end
    find("button#{@pet1.name}").click
    fill_in 'description', with: 'this is the reason I want a pet'
    click_on 'commit'
    within('div#progress') do
      expect(page).to have_content('Pending')
    end
  end
end