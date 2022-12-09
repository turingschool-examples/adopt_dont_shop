require 'rails_helper'

RSpec.describe 'visit application show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

    @fred = @shelter.pets.create!(adoptable: true, age: 8, breed: 'Basset Hound', name: 'Fred')
    @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
    @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
    @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

    @app1 = Application.create!(name: 'Frank Sinatra', street_address: '69 Sinatra Way', city: 'Nashville', state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs", status: 'In Progress')
  end

  it 'displays application details' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/applications/#{@app1.id}"

    expect(page).to have_content("Applicant Details:")
    expect(page).to have_content("Name: #{@app1.name}")
    expect(page).to have_content("Address: #{@app1.street_address} #{@app1.city}, #{@app1.state} #{@app1.zip_code}")
    expect(page).to have_content("Application: #{@app1.description}")
    expect(page).to have_content("Application Status: #{@app1.status}")
    expect(page).to have_content("This Application is for: #{@buster.name}, #{@marlowe.name}")
  end

  it 'has links to each pet listed in application' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/applications/#{@app1.id}"

    expect(find_link(@buster.name)[:href]).to eq("/pets/#{@buster.id}")
    expect(find_link(@marlowe.name)[:href]).to eq("/pets/#{@marlowe.id}")
  end
end
