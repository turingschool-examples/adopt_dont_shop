require 'rails_helper'

RSpec.describe "Applicant Show" do
  before(:each)do 
    @olivia = Applicant.create!(name: "Olivia Valentin",
                                street: "1234 Main St",
                                city: "Denver",
                                state: "CO",
                                zip: "80203",
                                good_home: "I have vetenarian expierence")

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

    expect(page).to have_content("#{@olivia.name}")
    expect(page).to have_content("#{@olivia.street}")
    expect(page).to have_content("#{@olivia.city}")
    expect(page).to have_content("#{@olivia.state}")
    expect(page).to have_content("#{@olivia.good_home}")
    expect(page).to have_content("#{@olivia.status}")
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_2.name}")
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
