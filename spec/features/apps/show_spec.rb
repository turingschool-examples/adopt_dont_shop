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
  end 

  it 'can add pets to an application' do 
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Add a Pet to this Application", with: "James")
    click_button("Search")

    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_content("James")
  end 

  it 'can search for pets for an application' do 
    fill_in("Add a Pet to this Application", with: "James")
    click_button("Search")

    within '#James' do 
      click_button "Adopt this Pet"
      expect(current_path).to eq("/apps/#{@application_1.id}")
    end 

    expect(current_path).to eq("/apps/#{@application_1.id}")
    expect(page).to have_button("Adopt this Pet")
    expect(page).to have_content("James")
  end 
end 