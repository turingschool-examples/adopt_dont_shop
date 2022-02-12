require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do
    @application = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :in_progress)
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = @application.pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = @application.pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = @application.pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = @application.pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
  end

  it "shows the application and all it's attributes" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.full_address)
    expect(page).to have_content(@application.status)
  end
end
