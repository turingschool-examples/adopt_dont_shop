require 'rails_helper'

RSpec.describe "Application Show Page" do

  before :each do
    @application_1 = Application.create!(name: 'Alex Horn', street_address: '12 Not A Real Ln', city: 'Westminster', state: 'CO', zipcode: '80021', why_me: "Well, I guess, I just REALLY really wanted a dog.")
    @application_2 = Application.create!(name: 'Bob Ross', street_address: '21 Happy Tree Ln', city: 'Daytona Beach', state: 'FL', zipcode: '32122', why_me: "I live on a happy little farm on the edge of town, we've got plenty of space to let the poor feller run and solve mysteries.")
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create!(name: 'Daisy', age: 4, breed: 'American Bully', adoptable: true, shelter_id: @shelter.id)
    @pet_applications_1 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    @pet_applications_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_applications_3 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_2.id)

  end

  describe "show page shows applicant info" do
    visit "/applications/#{@appication_2.id}/"

    expect(page).to have_content(@application_2.name)
    expect(page).to have_content(@application_2.street_address)
    expect(page).to have_content(@application_2.city)
    expect(page).to have_content(@application_2.state)
    expect(page).to have_content(@application_2.zipcode)
    expect(page).to have_content(@application_2.why_me)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_link(href: "/pets/#{@pet_1.id}/")
    expect(page).to have_content("In Progress")
  end
end
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
