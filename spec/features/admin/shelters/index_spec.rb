require 'rails_helper'

RSpec.describe "Admin Shelters Index" do
  before :each do
    @aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @mystery_bldg = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @boulder = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)

    @lobster = @mystery_bldg.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
    @thomas = Applicant.create!(name: "Thomas", street: "1515 15 Ave", city: "Denver", state: "CO", zip: "80203", good_home: "Lots of love and land!", status: "Pending")
    PetApplicant.create!(applicant: @thomas, pet: @lobster)
  end

  it "displays all shelters' names in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@mystery_bldg.name).to appear_before(@boulder.name)
    expect(@boulder.name).to appear_before(@aurora.name)
    expect(@aurora.name).to_not appear_before(@mystery_bldg.name)
  end

  describe 'shelters with pending applications' do
    it 'has section for the name of shelters with pending applications' do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications")
      
    end
  end
end