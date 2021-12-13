require "rails_helper"

describe 'application show page' do

  it ' I see name, address, description, status' do
    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"wade")
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"bob")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701' )
    @application_pet = PetApplication.create!(pet_id:@pet1.id, application_id: @application1.id)

    visit "/applications/#{@application1.id}"
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip)
    expect(page).to have_link("#{@pet1.name}")

  end

  it 'Links to all' do
    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"wade")
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"bob")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701' )
    @application_pet = PetApplication.create!(pet_id:@pet1.id, application_id: @application1.id)

    visit "/applications/#{@application1.id}"
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    click_link "#{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  it "has section to add pet to application" do
    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"wade")
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"bob")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701' )
    @application_pet = PetApplication.create!(pet_id:@pet1.id, application_id: @application1.id)

    visit "/applications/#{@application1.id}"
    expect(page).to have_content("Add a Pet to This Application")
    expect(page).to have_button("Search")
    fill_in('Pet name', with: "#{@pet2.name}")
    click_button "Search"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content(@pet2.name)
    expect(page).to_not have_content(@pet3.name)
  end

  it "I see a button to Adopt this Pet When I click one of these buttons" do
    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"wade")
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"bob")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701' )
    @application_pet = PetApplication.create!(pet_id:@pet1.id, application_id: @application1.id)

    visit "/applications/#{@application1.id}"
    expect(page).to have_content("Add a Pet to This Application")
    expect(page).to have_button("Search")
    fill_in('Pet name', with: "#{@pet2.name}")
    click_button "Search"
    click_button "Adopt this Pet"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content(@pet2.name)
  end

  it "adds one or more pet to the application and has section to submit application" do
    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"wade")
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 3, breed:"lab", name:"bob")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701' )

    visit "/applications/#{@application1.id}"

    expect(page).to have_button("Search")
    fill_in('Pet name', with: "#{@pet1.name}")
    click_button "Search"
    click_button "Adopt this Pet"
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("Why would I be a good owner")
    expect(page).to have_button("Submit Application")
    fill_in 'Description', with: "Test"
    click_on("Submit Application")
    expect(current_path).to eq("/applications/#{@application1.id}")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content('Add a Pet to This Application')
    expect(page).to have_content("Test")

  end

end
