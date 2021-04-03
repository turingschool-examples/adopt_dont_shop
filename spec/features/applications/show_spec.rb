require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do
    @foothills_shelter = Shelter.create!(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: true, rank: 4)
    @ramone = @foothills_shelter.pets.create!(name: 'Ramone', breed: 'hound', age: 2, adoptable: true)
    @lawson = @foothills_shelter.pets.create!(name: 'Lawson', breed: 'Australian shepherd', age: 6, adoptable: true)
    @petunia = @foothills_shelter.pets.create!(name: 'Petunia', breed: 'chihuahua', age: 1, adoptable: true)

    @hayley_williams = Application.create!(applicant_name: 'Hayley Williams',
      street: "789 Rose St.",
      city: "Golden",
      state: "CO",
      zip_code: "80123",
      pet_names: "Petunia",
      statement: "I sing to my pets",
      status: "accepted"
      )
    @hayley_williams.pets << @petunia

    @jeff_rosenstock = Application.create!(applicant_name: 'Jeff Rosenstock',
      street: "456 Mississippi Ave.",
      city: "Denver",
      state: "CO",
      zip_code: "80012",
      pet_names: "Lawson",
      statement: "I have a fenced in yard",
      status: "pending"
      )
    @jeff_rosenstock.pets << @lawson

    visit "/applications/#{@hayley_williams.id}"
  end
  it "shows the application and all of it's attributes" do
    expect(page).to have_content(@hayley_williams.applicant_name)
    expect(page).to have_content(@hayley_williams.street)
    expect(page).to have_content(@hayley_williams.city)
    expect(page).to have_content(@hayley_williams.state)
    expect(page).to have_content(@hayley_williams.zip_code)
    expect(page).to have_content(@hayley_williams.pet_names)
    expect(page).to have_content(@hayley_williams.statement)
    expect(page).to have_content(@hayley_williams.status)
    expect(page).to_not have_content(@jeff_rosenstock.applicant_name)
  end

# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)

# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  it "has a status of 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
    expect(@hayley_williams.status).to eq("accepted")
  end

end
