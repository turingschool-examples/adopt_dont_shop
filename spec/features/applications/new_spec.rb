require "rails_helper"
RSpec.describe 'new application' do
  before(:each) do
    @application = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :in_progress)
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @pet_application = PetApplication.create!(pet: @pet_1, application: @application, approved: true)
    @pet_application = PetApplication.create!(pet: @pet_2, application: @application, approved: true)
    @pet_application = PetApplication.create!(pet: @pet_3, application: @application, approved: true)
    @pet_application = PetApplication.create!(pet: @pet_4, application: @application, approved: true)
  end

  it 'displays a link to start an application' do
    visit '/pets'
    expect(page).to have_link("Start an application")
    click_link("Start an application")
    expect(page).to have_current_path("/applications/new")
  end

  it 'can create a new application and goes to its show page' do
    visit '/applications/new'

    fill_in('Name', with: 'Noel Sitnick')
    fill_in('street_address', with: '11111 Make Believe Road')
    fill_in('City', with: 'Baltimore')
    fill_in('State', with: 'MD')
    fill_in('zip_code', with: '00001')
    click_on 'Submit'
    new_application = Application.last

    expect(current_path).to eq("/applications/#{new_application.id}")
    expect(page).to have_content('Noel Sitnick')
  end

  it 'given incomplete form it re-renders the new application form' do
    visit '/applications/new'

    fill_in 'Name', with: ''
    click_button 'Submit'

    expect(page).to have_content("Error: Name can't be blank")
    expect(page).to have_current_path("/applications/new")
  end
end
