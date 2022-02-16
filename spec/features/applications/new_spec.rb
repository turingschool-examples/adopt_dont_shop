require 'rails_helper'
#   Starting an Application
#
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"


RSpec.describe 'start an application' do
  it 'visit the pet index and finds a link for start application'do
    # shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    # pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
# application = Application.create!(name: 'Becky Nisttahuz', street_address: '1471 King St', city: 'Denver', state: 'CO', zip_code: '80204', status: 'In Progress', description: 'Looking for a cat')

    visit '/pets'

    expect(page).to have_link('Start an Application')

    click_on('Start an Application')

    expect(current_path).to eq('/applications/new')
    expect(page).to have_field('name')
    expect(page).to have_field('street_address')
    expect(page).to have_field('city')
    expect(page).to have_field('state')
    expect(page).to have_field('zip_code')
    expect(page).to have_field('description')
   end



   it 'can create a new form' do
   #shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  # pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
  #application_1 = Application.create!(name: 'tere', street_address: '1471 King St', city: 'Denver', state: 'CO', zip_code: '80204', status: 'In Progress', description: 'Looking for a cat')

    visit '/pets'

    click_on('Start an Application')

    fill_in('name', with: 'Becky Nisttahuz')
    fill_in('street_address', with: '1471 King St')
    fill_in('city', with: 'Denver')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '80204')
    fill_in('description', with: 'I want a cat')

    click_button('Submit')
    # application_2 = Application.last
    expect(Application.all.count).to eq(2)
    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Becky Nisttahuz")
    expect(page).to have_content("1471 King St")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("80204")
    expect(page).to have_content("I want a cat")

    # expect(application_2.status).to eq("In Progress")
  end

 # describe 'if fail to fill in all boxes, cant submit application' do
  it 'user is taken back to new application' do
    visit '/pets'

    click_on('Start an Application')

    fill_in('name', with: "Becky Nisttahuz")
    fill_in('street_address', with: '1471 King St')
    fill_in('city', with: 'Denver')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '80204')
    # fill_in('description', with: 'I want a cat')

    click_button('Submit')

    expect(page).to have_content("Error: Description can't be blank")
  
  end
end
