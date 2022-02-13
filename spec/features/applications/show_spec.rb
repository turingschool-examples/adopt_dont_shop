require 'rails_helper'

RSpec.describe 'application' do
  before :each do
    @dfl = Shelter.create!(foster_program: true, name: "Dumb friends League", city: "Denver", rank: 53)
    @spike = @dfl.pets.create!(adoptable: true, age: 1, breed: "Golden Retriever", name: "Spike")
    @meow = @dfl.pets.create!(adoptable: true, age: 2, breed: "tiger", name: "Meow")
    @jim = Application.create!(name: "Jim", street_address: "123 Test Street", city: "Makebelivevill", state: "Florida", zip_code: 80233, description: "Need Companion")
    PetApplication.create!(pet: @spike, application: @jim)
  end

  it 'has a show page' do

    visit "/applications/#{@jim.id}"

    expect(page).to have_content(@jim.name)
    expect(page).to have_content(@jim.street_address)
    expect(page).to have_content(@jim.city)
    expect(page).to have_content(@jim.state)
    expect(page).to have_content(@jim.zip_code)
    expect(page).to have_content(@jim.description)
    expect(page).to have_content(@jim.status)

    expect(page).to have_content(@spike.name)

  end

  it 'pet name is a link to pet show page' do

    visit "/applications/#{@jim.id}"

    expect(page).to have_link("#{@spike.name}")

    click_link("#{@spike.name}")

    expect(current_path).to eq("/pets/#{@spike.id}")

  end

  it 'pet name is a link to pet show page' do

    visit "/applications/#{@jim.id}"

    expect(page).to have_link("#{@spike.name}")

    click_link("#{@spike.name}")

    expect(current_path).to eq("/pets/#{@spike.id}")

  end

  it 'can add pet to this application' do

    visit "/applications/#{@jim.id}"

    expect(page).to have_content("Add a Pet to this Application:")

    fill_in :search, with: "Meow"
    click_button("Search")

    expect(current_path).to eq("/applications/#{@jim.id}")

    within('#pet-results') do
      expect(page).to have_content("#{@meow.name}")
    end
  end

end
