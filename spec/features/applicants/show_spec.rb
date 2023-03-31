require 'rails_helper'

RSpec.describe "Applicant Show" do
  before(:each)do 
    @olivia = Applicant.create!(name: "Olivia Valentin",
                                address: "1234 Main St, Denver, CO 80203",
                                reasons_for_adoption: "I love animals",
                                status: "In Progress")
    @shelter = Shelter.create!(name: 'Aurora shelter', 
                               city: 'Aurora, CO', 
                               foster_program: false, 
                               rank: 9)
    @pet_1 = Pet.create(adoptable: true,
                        age: 1, 
                        breed: 'sphynx', 
                        name: 'Lucille Bald', 
                        shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, 
                        age: 3, 
                        breed: 'doberman', 
                        name: 'Lobster', 
                        shelter_id: @shelter.id)
    PetApplicant.create!(applicant: @olivia,
                         pet: @pet_1)
    PetApplicant.create!(applicant: @olivia,
                         pet: @pet_2)
  end
  
  it "shows applicant's attributes" do
    visit "/applicants/#{@olivia.id}"
    save_and_open_page
    expect(page).to have_content("Name: #{@olivia.name}")
    expect(page).to have_content("Address: #{@olivia.address}")
    expect(page).to have_content("Reasons for Adoption: #{@olivia.reasons_for_adoption}")
    expect(page).to have_content("Status: #{@olivia.status}")
    expect(page).to have_content("Currently applying for: #{@pet_1.name}")
    expect(page).to have_content("Currently applying for: #{@pet_2.name}")
  end
  
  it "has link to each pet's show page" do
    visit "/applicants/#{@olivia.id}"

    click_link "#{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applicants/#{@olivia.id}"

    click_link "#{@pet_2.name}"

    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
end
