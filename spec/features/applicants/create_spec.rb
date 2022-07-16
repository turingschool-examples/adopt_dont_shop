require 'rails_helper'


RSpec.describe 'New Applicant form page' do
  it 'links to a new page app form' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    bob_1 = Applicant.create(name: "Billy Bob", address: "Street address 6093", description: "I'm bob", status: "In Progress", zip: 22323, city: "Denver", state: "CO")
    bob_2 = Applicant.create(name: "Freiza", address: "Acne Lane 80422", description: "I'm freiza 2", status: "In Progress", zip: 80029, city: "Bouler", state: "CO")
    bob_3 = Applicant.create(name: "James Maddy", address: "Street address 6093", description: "I'm in Wyoming", status: "Progress", zip: 71123, city: "Lander", state: "WY")

    visit '/pets'

    click_link("Start an Application", :match => :first)

    expect(page).to have_content("Pet Adoption Form")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('Zip')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Description')
  end
end





# Starting an Application

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
