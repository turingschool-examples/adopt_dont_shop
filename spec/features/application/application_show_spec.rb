require 'rails_helper'

RSpec.describe 'aplication show page' do
  before :each do
    @application = Application.create!(name: "Thomas Turner", address_street: "234 Sands St.", address_city: "Chicago", address_state: "Illinois", address_zip_code: 60007, description: "I love pets and have lots of space in the back yard", status: "pending")
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', application_id: @application.id, shelter_id: shelter.id)

  end

  it 'shows all application info' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Thomas Turner")
    expect(page).to have_content("234 Sands St.")
    expect(page).to have_content("Chicago")
    expect(page).to have_content("Illinois")
    expect(page).to have_content(60007)
    expect(page).to have_content("I love pets and have lots of space in the back yard")
    expect(page).to have_content("Bare-y Manilow")
    expect(page).to have_content("pending")
  end

  it 'all pet names are links to their show page' do
    visit "/applications/#{@application.id}"

    click_link(@pet_1.name)

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Bare-y Manilow")
  end
end
