require 'rails_helper'

RSpec.describe 'Application show view' do
  before :each do
    @shelter = Shelter.create({name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9})

    @application = Application.create({
      name: "Jeff",
      street_address: "123 Main Street",
      city: "Denver",
      state: "CO",
      zip_code: 22314,
      reason: "Nice person"
    })
    @pet_3 = Pet.create(adoptable: true, age: 2, breed: 'Shih-Poo', name: 'Frankie', shelter_id: @shelter.id)
  end

  it 'has the ability to approve a pet' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content("Jeff")
    expect(page).to have_content("123 Main Street, Denver CO, 22314")
    expect(page).to have_content("Nice person")
    expect(page).to have_content("Lucille Bald")
    expect(page).to have_content("Dogmin")
    expect(page).to have_content("In Progress")

    click_button "Approve Dogmin"

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_content("Approve Dogmin")
    expect(page).to have_content("Approved")
  end
end