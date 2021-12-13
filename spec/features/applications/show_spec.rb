require "rails_helper"

describe 'application show page' do
  before do

    @shelter1 = Shelter.create!(foster_program: true, name:"Humane Society", city: "Fort Collins", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 1, breed:"Dachshund", name:"Rusko")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"Beagle", name:"Rosie")
    @application1 = Application.create!(name:'Kelly', address: '123 test st', city: 'Boulder', state: 'CO', zip: '80016', description: "Application Description", status: 'in progress' )
    @pet_application = PetApplication.create!(pet_id: @pet1.id, application_id: @application1.id)
    visit "/applications/#{@application1.id}"
  end

  it ' I see name, address, description, status' do
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.zip)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
  end

  it 'Links to all pets' do
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    click_link "#{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  xit 'I can search for pets to add to this application' do
    expect(page).to have_content("Add a Pet to this Application")
    fill_in 'Pet name', with: "#{@pet1.name}"
    click_button "Submit"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("#{@pet1.name}")
    fill_in 'Pet name', with: "#{@pet2.name}"
    click_button "Submit"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("#{@pet2.name}")
  end

  it 'Add a Pet to an Application' do
    fill_in 'Pet name', with: "#{@pet2.name}"
    click_button "Submit"
    expect(page).to have_button("Adopt this Pet")
    click_button "Adopt this Pet"
    save_and_open_page
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("Pets on this Application: #{@pet2.name}")
  end
end
