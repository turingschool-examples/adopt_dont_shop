require 'rails_helper'

RSpec.describe 'visit application show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

    @fred = @shelter.pets.create!(adoptable: true, age: 8, breed: 'Basset Hound', name: 'Fred')
    @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
    @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
    @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

    @app1 = Application.create!(name: 'Frank Sinatra', street_address: '69 Sinatra Way', city: 'nashville', state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs")
  end

  it 'page exists' do
    visit "/applications/#{@app1.id}"

    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_content(@buster.name)
    expect(page).to have_content(@marlowe.name)
  end
end
