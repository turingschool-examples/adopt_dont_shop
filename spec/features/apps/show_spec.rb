require 'rails_helper'

RSpec.describe 'the pet_apps show page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @app = App.create(name: 'Scooby', street: "123", city:"fake", state: "fake", zip: 48248)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Fluffington', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter.id)
    visit "/apps/#{@app.id}"
  end
  # Story 1
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it 'has the attributes of the applicant' do
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.street)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip)
    expect(page).to have_content("In Progress")
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
    fill_in 'name', with: 'Fluff'
    find("input[@value='search']").click
    expect(page).to have_button("Adopt #{@pet_2.name}")
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
    fill_in 'name', with: 'Fluff'
    find("input[@value='search']").click
    #binding.pry
    find("input[@id=#{@pet_2.id}]").click
    expect(current_path).to eq("/apps/#{@app.id}")
    within("div#pets_on_app") do
      expect(page).to have_content(@pet_2.name)
    end
  end

  # Story 6
  # When I visit an application's show page
  # And I have added one or more pets to the application
  # Then I see a section to submit my application

  it 'Only once a pet is on app, there is a submit button and an input for good pet reasoning' do
    #US 7, no submit button without pets on app
    #doesn't have submit button
    expect(page).to have_css("input[@value='search']")
    expect(page).to_not have_css("input[@value='Apply to Adopt']")
    #add animal to app
    fill_in 'name', with: 'Fluff'
    find("input[@value='search']").click
    find("input[@id=#{@pet_2.id}]").click
    #expect submit button to be there
    expect(page).to have_css("input[@value='Apply to Adopt']")
    #expect 
    within("div#pets_on_app") do
      expect(page).to have_content(@pet_2.name)
    end
  end

  # And in that section I see an input to enter why I would make a good owner for these pet(s)
  # When I fill in that input
  # And I click a button to submit this application
  # Then I am taken back to the application's show page
  # And I see an indicator that the application is "Pending"
  # And I see all the pets that I want to adopt
  # And I do not see a section to add more pets to this application
  it 'Once submitted, taken back to app, which now shows pending (in progress before)' do
    within("h6#status") do
      expect(page).to have_content('In Progress')
    end
    fill_in 'name', with: 'Fluff'
    find("input[@value='search']").click
    find("input[@id='#{@pet_2.id}']").click
    fill_in 'description', with: 'this is the reason I want a pet'
    find("input[@value='Apply to Adopt']").click
    within("h6#status") do
      expect(page).to have_content('Pending')
    end
  end

  # Story 8
  # When I visit an application show page
  # And I search for Pets by name
  # Then I see any pet whose name PARTIALLY matches my search
  # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
  it 'has partial match for pet names' do
    expect(page).to_not have_selector 'input', id: "#{@pet_2.id}"

    fill_in 'name', with: 'Fluff'
    find("input[@value='search']").click
 
    expect(page).to have_selector 'input', id: "#{@pet_2.id}"
  end

  # Story 9
  # When I visit an application show page
  # And I search for Pets by name
  # Then my search is case insensitive
  # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
  it 'has case insensitive partial match' do
    expect(page).to_not have_selector 'input', id: "#{@pet_2.id}"

    fill_in 'name', with: 'fluff'
    find("input[@value='search']").click
 
    expect(page).to have_selector 'input', id: "#{@pet_2.id}"
  end
end