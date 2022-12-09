require 'rails_helper'

RSpec.describe 'the pet application show page' do
  before(:each) do
    @fancy = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @coony = @fancy.pets.create!(name: 'Coony', breed: 'Maine Coon', age: 10, adoptable: true)
    @bloom = @fancy.pets.create!(name: 'Irishman', breed: 'irish wolfhound', age: 2, adoptable: true)
    
    @app1 = Application.create!(name: "Tucker", street_address: "1122 Blank St.", city: 'New York City', state: "NY", zip_code: "12121", description: "We have one happy dog and would love another!", status: "In Progress") 
    @app2 = Application.create!(name: "Sara", street_address: "2211 Other St.", city: 'Iowa City', state: "IA", zip_code: "33434", description: "Give pet please", status: "Pending") 
    
    @petapp1 = PetApplication.create!(pet: @coony, application: @app1)
    @petapp1 = PetApplication.create!(pet: @bloom, application: @app1)
    @petapp2 = PetApplication.create!(pet: @bloom, application: @app2)
  end

  it 'has the name, address, description, names of pets, and status displayed' do
    visit "/applications/#{@app1.id}"

    save_and_open_page
    # within block
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_content(@bloom.name)
    expect(page).to have_content(@coony.name)
    expect(page).to_not have_content(@app2.name)
  end

  it 'has links to each pet via the name of the pet on the applicaiton' do
    visit "/applications/#{@app1.id}"

    expect(page).to have_link "#{@coony.name}", href: "/pets/#{@coony.id}"
    expect(page).to have_link "#{@bloom.name}", href: "/pets/#{@bloom.id}"
  end
end