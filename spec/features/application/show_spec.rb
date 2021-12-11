require 'rails_helper'
describe 'application show page' do
  before do
    @shelter1 = Shelter.create!(foster_program: true, name:"Seth's Shelter", city: "Denver", rank: 2)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed:"Pitt Bull", name:"Penelope")
    @application1 = Application.create!(name:'Name1', address: '123 test st', city: 'Denver', state: 'Colorado', description: "Gimme the doggos", status: 'in progress' )
    visit "/applications/#{@application1.id}"


  end
  it ' I see name, address, description, status' do
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application1.address)
    expect(page).to have_content(@application1.city)
    expect(page).to have_content(@application1.state)
    expect(page).to have_content(@application1.description)
    expect(page).to have_content(@application1.status)
    require "pry"; binding.pry
    expect(page).to have_link("#{@pet1.name}")
  end
end
