require 'rails_helper'

RSpec.describe 'the application show' do

  before :each do
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, status: "In Progress")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, status: "Pending")
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    visit "/applications/#{@app_1.id}"
  end
  it "shows the application and all its attributes" do

    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip_code)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)
    expect(page).to_not have_content(@app_2.status)
    expect(page).to_not have_content(@app_2.name)
  end
end
