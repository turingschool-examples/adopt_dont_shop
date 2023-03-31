require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do 
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @application_1 = @pet_1.applications.create!(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      status: "",
      description: "I like pets",
      status: "In Progress"
  )
  @application_2 = Application.create!(
    name: "Charlie Puth",
    street_address:  "124 Main St",
    city: "Aurora",
    state: "CO",
    zip: "80012",
    status: "",
    description: "I haven't chosen any pets",
    status: "In Progress"
)
end

  it 'shows the name, description, pets, app status' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("#{@application_1.name}")
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@application_1.status}")
  end

  it 'shows address' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("#{@application_1.street_address}, #{@application_1.city} #{@application_1.state} #{@application_1.zip}")
  end

  it 'links to pet page' do
    visit "/applications/#{@application_1.id}"

    click_link("#{@pet_1.name}")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "doesn't have submit button" do
    visit "/applications/#{@application_2.id}"

    expect(page).not_to have_button("Submit Application")
  end

  it 'has a submit button and submits application' do
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_button("Submit Application")

    fill_in 'description', with: "Because, obviously"

    click_button "Submit Application"
    save_and_open_page

    expect(page).to have_current_path("/applications/#{@application_1.id}")
    expect(page).to have_content("Pending")
  end
end

#6 Submit an Applicaiton

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

# <%= f.text_field :criteria_reason, class:"form-control", placeholder:'Reason',
#       style:"#{'display:none' if f.object.criteria == ''}" %>