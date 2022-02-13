require 'rails_helper'

RSpec.describe 'Application Creation' do
  before :each do
    @dfl = Shelter.create!(foster_program: true, name: "Dumb friends League", city: "Denver", rank: 53)
    @spike = @dfl.pets.create!(adoptable: true, age: 1, breed: "Golden Retriever", name: "Spike")
    @meow = @dfl.pets.create!(adoptable: true, age: 2, breed: "tiger", name: "Meow")
    @jim = Application.create!(name: "Jim", street_address: "123 Test Street", city: "Makebelivevill", state: "Florida", zip_code: 80233, description: "Need Companion")
    @application_1 = PetApplication.create!(pet: @spike, application: @jim)
  end

  it "has a form to fill out that takes us new apllicants show page" do
    visit '/applications/new'

    fill_in('Name', with: 'John Stewart')
    fill_in('Street address', with: '123 Fake St')
    fill_in('City', with: 'Denver')
    fill_in('State', with: 'Colorado')
    fill_in('Zip code', with: 80233)
    fill_in('Description', with: 'Need Companion')
    click_button('Submit')

    new_applicant = Application.last

    expect(current_path).to eq("/applications/#{new_applicant.id}")

    expect(page).to have_content(new_applicant.name)
    expect(page).to have_content(new_applicant.street_address)
    expect(page).to have_content(new_applicant.city)
    expect(page).to have_content(new_applicant.state)
    expect(page).to have_content(new_applicant.description)
    expect(page).to have_content(new_applicant.status)
  end

  it "error message pops up when one or more fields are empty" do

    visit '/applications/new'

    fill_in('Name', with: 'John Stewart')
    fill_in('Street address', with: '123 Fake St')
    fill_in('City', with: 'Denver')
    #fill_in('State', with: 'Colorado')
    fill_in('Zip code', with: 80233)
    fill_in('Description', with: 'Need Companion')
    click_button('Submit')

    expect(current_path).to eq("/applications/new")

    expect(page).to have_content("Error: State can't be blank")
  end

end
