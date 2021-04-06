require 'rails_helper'

RSpec.describe 'applicants_pets show' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @applicant_1 = Applicant.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
    @applicant_2 = Applicant.create!(full_name: 'Yo Lo', street_address: '95837 Tomahawk Dr.', city: 'Cincinatti', state: 'OH', zipcode: 44567)
    @applicant_3 = Applicant.create!(full_name: 'Sam Smith', street_address: '34573 Board Rd.', city: 'Austin', state: 'TX', zipcode: 67875 )

    @application_1 = ApplicantsPet.create(description: 'blah', pet_id: @pet_1.id, applicant_id: @applicant_1.id )
    @application_2 = ApplicantsPet.create(description: 'aer', pet_id: @pet_2.id, applicant_id: @applicant_2.id )
    @application_3 = ApplicantsPet.create(description: 'TBD', pet_id: @pet_3.id, applicant_id: @applicant_3.id )
  end

  it "shows the application and all of its attributes" do
    visit "/applicants_pets/#{@application_1.id}"

    expect(page).to have_content("Applicant: #{@applicant_1.full_name}")
    expect(page).to have_content("Street Address: #{@applicant_1.street_address}")
    expect(page).to have_content("City: #{@applicant_1.city}")
    expect(page).to have_content("State: #{@applicant_1.state}")
    expect(page).to have_content("Zipcode: #{@applicant_1.zipcode}")
    expect(page).to have_content("Description: #{@application_1.description}")
    expect(page).to have_content("Applying For: #{@pet_1.name}")

    expect(page).to have_link(@pet_1.name)
    expect(page).to have_content("In Progress")
  end

  it "clicks the applied for pet and redirects to its show page" do
    visit "/applicants_pets/#{@application_1.id}"
    expect(page).to have_current_path("/applicants_pets/#{@application_1.id}")

    expect(page).to have_link(@pet_1.name)
    click_link(@pet_1.name)
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end
end
