require 'rails_helper'

RSpec.describe 'Show Shelter Admin Page' do

  before(:each) do
    @shelter2 = Shelter.create!(foster_program: "true", name:"Pets R Us", city: "Fort Collins", rank:"2")
    @watson = @shelter2.pets.create!(adoptable: "true", name: "Watson", breed:"mutt", age:"3")
    @taos = @shelter2.pets.create!(adoptable: "true", name: "Taos", breed:"mutt", age:"1")
    
    @shelter1 = Shelter.create!(foster_program: "true", name:"Furry Friends", city: "Denver", rank:"3")
    @cookie = @shelter1.pets.create!(adoptable: "true", name: "cookie", breed:"chihuahua", age:"5")
    @spot = @shelter1.pets.create!(adoptable: "true", name: "spot", breed:"dalmation", age:"2")
    @dash = @shelter1.pets.create!(adoptable: "false", name: "dash", breed:"golden retriever", age:"13")

    @john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", status: 'Pending')
    @jane_johnson_app = Application.create!(name: 'Jane Johnson', street_address: '2548 Bungalow Ave', city: 'Spokane', state: 'WA', zip_code: 27338, description: 'I like cats. Give me some.', status: 'Pending')
    @roberta_benson_app = Application.create!(name: 'Roberta Benson', street_address: '700 W 18th Ave Apt 101', city: 'Bend', state: 'OR', zip_code: 84585, description: 'I am very responsible and need animal friends because I have no human friends.', status: 'Pending')

    @john_doe_app.pets << [@cookie, @watson]
    @jane_johnson_app.pets << [@dash]
    @roberta_benson_app.pets << [@cookie, @dash]
  end

  it 'has a title' do
    visit("/admin/shelters/#{@shelter1.id}")

    expect(page).to have_content("#{@shelter1.name} Admin Page")
  end
  
  it 'has a list of pets with pending applications' do
    visit("/admin/shelters/#{@shelter1.id}")

    expect(page).to have_content("Action Required")
    expect(page).to have_content(@cookie.name)
    expect(page).to have_content(@dash.name)
    expect(page).to_not have_content(@spot.name)
    expect(page).to_not have_content(@watson.name)
    expect(page).to_not have_content(@taos.name)
  end

  it 'works for a different shelter' do
    visit("/admin/shelters/#{@shelter2.id}")

    expect(page).to have_content("Action Required")
    expect(page).to have_content(@watson.name)
    expect(page).to_not have_content(@taos.name)
    expect(page).to_not have_content(@cookie.name)
    expect(page).to_not have_content(@dash.name)
    expect(page).to_not have_content(@spot.name)
  end
end