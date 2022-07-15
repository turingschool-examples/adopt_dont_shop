require 'rails_helper'
#US - 25
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
# Name
# Street Address
# City
# State
# Zip Code

RSpec.describe "Create Application" do 
   it 'populates a new application form to fill in with name, address, city, state, and zip code' do 
         new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555, names_pets_wanted: "Fido", description: "they love pets!", application_status: "In Progress")
         shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
         ApplicantPet.create!(pet: fido, applicant: new_applicant)

         visit "/applications/#{new_applicant.id}/new"
         
         expect(find('form')).to have_content('Name')
         expect(find('form')).to have_content('Address')
         expect(find('form')).to have_content('City')
         expect(find('form')).to have_content('State')
         expect(find('form')).to have_content('Zip')
   end
end
