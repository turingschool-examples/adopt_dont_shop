require "rails_helper"

RSpec.describe 'applications show page' do

  before:each do
    @application_1 = Application.create!(name: 'Pam Pulzone', street_address: '66225 Wallace Rd', city: 'Bend', state: 'OR', zip: 97702, status: 'In Progress')
    @application_2 = Application.create!(name: 'Dan Boston', street_address: '774 Boone Rd', city: 'Greenville', state: 'SC', zip: 56843, status:  'In Progress')
    @shelter_1= Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'HSCO', city: 'Bend, OR', foster_program: true, rank: 4)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(adoptable: false, age: 8, breed: 'mix', name: 'Kumquat', shelter_id: @shelter_2.id)
   
  end

  it 'it shows details of the application' do
    
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.status)
    
    expect(page).to_not have_content(@application_2.name)
    # expect(page).to_not have_content(@application_1.description)
  end
  
  it 'shows a search field to add pets to an application if the application status is 
    "In Progress"' do

    visit "/applications/#{@application_1.id}"
    
    expect(@application_1.status).to eq("In Progress")

    has_field?(:search)

    fill_in 'Search', with: 'L'
    click_on 'Search'

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    
    expect(page).to_not have_content(@pet_3.name)
  end

  it "has an 'Adopt this Pet' button next to each animal name that matches search criteria" do
    visit "/applications/#{@application_1.id}"
    
    fill_in 'Search', with: 'L'
    click_on 'Search'

    within("#application-#{@pet_1.id}") do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Adopt this Pet")
    end 

    within("#application-#{@pet_2.id}") do
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Adopt this Pet")
      
      click_on "Adopt this Pet"
    end
    
    fill_in 'Search', with: 'L'
    click_on 'Search'
    
    within("#application-#{@pet_1.id}") do
      click_on "Adopt this Pet"
    end 

    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_1.name)
  end

  it "if a pet has not been added to the application, there will not be 
    a text field for user to fill in why they would be a good home." do
      
      visit "/applications/#{@application_1.id}"
    
      has_no_field?(:description)
  end

  it "if a pet has not been added to the application, there will not be 
    a 'Submit Application' button." do
      
      visit "/applications/#{@application_1.id}"
      
      has_no_button?("Submit Application")
    end

  it "once a pet has been added to the application, a text box will 
    appear for the user to enter in why they would be a good pet owner" do
      
      visit "/applications/#{@application_1.id}"
    
      has_no_field?(:description)

      fill_in 'Search', with: 'L'
      click_on 'Search'
      within("#application-#{@pet_2.id}") do
        click_on "Adopt this Pet"
      end

      has_field?(:description)

      expect(page).to have_content("Adoption Interest: #{@pet_2.name}")
    end 

  it "when an application is submitted, the application status should be changed from 
    'In Progress' to 'Pending' " do

      visit "/applications/#{@application_1.id}"

      expect(@application_1.status).to eq("In Progress")

      fill_in 'Search', with: 'L'
      click_on 'Search'
      within("#application-#{@pet_2.id}") do
        click_on "Adopt this Pet"
      end

      has_field?(:description)

      fill_in :description, with: "I love dogs"
      click_on "Submit Application"

      updated_app = Application.find(@application_1.id)

      expect(updated_app.status).to eq("Pending")
      expect(updated_app.description).to eq("I love dogs")

  end

  it "when the user fills in the description text box and hits submit, they are taken
    back to the applications show page, there is an indicator that the application is
    now 'Pending' and there is a list of all of the pets the user wants to adopt. The
    show page no longer has a section to add more pets to the application" do

      visit "/applications/#{@application_1.id}"

      fill_in 'Search', with: 'L'
      click_on 'Search'
      within("#application-#{@pet_2.id}") do
        click_on "Adopt this Pet"
      end

      fill_in "description", with: "I love dogs"
      click_on "Submit Application"

      expect(current_path).to eq("/applications/#{@application_1.id}")
      has_field?(:description)

      updated_app = Application.find(@application_1.id)

      expect(page).to have_content(updated_app.description)
      expect(page).to have_content("Adoption Interest: #{@pet_2.name}")
      expect(updated_app.status).to eq("Pending")

      expect(page).to_not have_content('Search')
    end



    

  # xit "will only create one text box for user to fill out with why they would
  #   be a good home, regardless of how many animals are added to the 
  #   application" do
  #     # I have made it so this is true, but can't figure out how to test that a field is
  #     # unique. Need to research further

  #     visit "/applications/#{@application_1.id}"
    
  #     has_no_field?(:description)

  #     fill_in 'Search', with: 'L'
  #     click_on 'Search'
  #     within("#application-#{@pet_2.id}") do
  #       click_on "Adopt this Pet"
  #     end

  #     fill_in 'Search', with: 'L'
  #     click_on 'Search'
  #     within("#application-#{@pet_1.id}") do
  #       click_on "Adopt this Pet"
  #     end

  #     #unsure how to validate or if we need to right now
  # end

end