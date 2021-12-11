require 'rails_helper'
RSpec.describe 'the application show' do 
  before :each do 
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pug", name: "James")
    @application_1 = @pet_1.apps.create!(name: "Karan", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)

    visit "/apps/#{@application_1.id}"
  end 
  it "shows the appliation and all it's attributes" do 
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
    save_and_open_page
  end 
end 