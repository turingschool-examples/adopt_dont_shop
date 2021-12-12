require "rails_helper"

describe 'application show page' do
  before do

    @shelter1 = Shelter.create!(foster_program: true, name:"wade shelter", city: "Bear", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"golden", name:"gus")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701', description: "this is a description", status: 'in progress' )
    @application_pet = PetApplication.create!(pet_id:@pet1.id, application_id: @application1.id)

    visit "/applications/#{@application1.id}"

  end
  it ' I see name, address, description, status' do
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.zip)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
    expect(page).to have_link("#{@pet1.name}")
  end

  it 'Links to all' do
    expect(page).to have_link("#{@pet1.name}", href: "/pets/#{@pet1.id}")
    click_link "#{@pet1.name}"
    expect(current_path).to eq("/pets/#{@pet1.id}")
  end
end
