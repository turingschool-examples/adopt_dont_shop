# require 'rails_helper'
#
# RSpec.describe 'applying for a pet' do
#   xit 'should join applicants with the pets in which they are applying' do
#     shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     applicant = Application.create!(
#               name: 'Mike Dao',
#               street_address: '245 Maple St',
#               city: 'Centennial',
#               state: 'Colorado',
#               zip_code: '80112',
#               applicant_bio: 'My dog needs another to chase up trees.',
#               application_status: 'Pending')
#
#     pet = applicant.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
#     pet2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
#     pet3 = applicant.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
#     pet4 = applicant.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)
#
#     # ApplicationPet.create!(pet: pet, application: applicant)
#     # ApplicationPet.create!(pet: pet2, application: applicant)
#
#     visit "/applications/#{applicant.id}"
#
#     expect(page).to have_content('Mike Dao')
#   end
# end
