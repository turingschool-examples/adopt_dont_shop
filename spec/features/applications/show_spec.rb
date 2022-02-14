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

  it 'can show pets to add to this application' do

    visit "/applications/#{@jim.id}"

    expect(page).to have_content("Add a Pet to this Application:")

    fill_in :search, with: "Meow"
    click_button("Search")

    expect(current_path).to eq("/applications/#{@jim.id}")

    within('#pet-results') do
      expect(page).to have_content("#{@meow.name}")
    end
  end

  it 'can add pets to this application' do

    visit "/applications/#{@jim.id}"

    fill_in :search, with: "Meow"
    click_button("Search")

    expect(page).to have_link("Adopt this Pet")

    click_link("Adopt this Pet")

    expect(current_path).to eq("/applications/#{@jim.id}")

    expect(page).to have_content("Meow")
  end

  it 'Can submit an application' do

    visit "/applications/#{@jim.id}"

    fill_in :search, with: "Meow"
    click_button("Search")

    click_link("Adopt this Pet")

    expect(page).to have_content("Why I would make a good owner for these pet(s)")
    expect(page).to have_button("Submit Application")
  end

  it 'Once Submitted I see Pending Status ' do

    visit "/applications/#{@jim.id}"

    fill_in :search, with: "Meow"
    click_button("Search")

    click_link("Adopt this Pet")

    fill_in :submit, with: "Cuz I will"

    click_button("Submit Application")

    expect(current_path).to eq("/applications/#{@jim.id}")

    expect(page).to have_content("Pending")
  end

  it "submit application doesn't show if there are no pets" do
    mark = Application.create!(name: "Mark", street_address: "123 Test Street", city: "Makebelivevill", state: "Florida", zip_code: 80233, description: "Need Companion")

    visit "/applications/#{mark.id}"

    expect(mark.pets).to eq([])

    expect(page).to_not have_content("Why I would make a good owner for these pet(s)")

    expect(page).to_not have_link("Why I would make a good owner for these pet(s)")
  end

end
