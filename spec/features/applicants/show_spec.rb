require 'rails_helper'

RSpec.describe 'applicant show page' do
  it 'shows the applicant and all of its attributes' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
    applicant = Applicant.create!(
                          name: 'Mike Dao',
                          street_address: '245 Maple St',
                          city: 'Centennial',
                          state: 'Colorado',
                          zip_code: 80112,
                          applicant_bio: 'My dog needs another to chase up trees.',
                          application_status: 'Pending')

      visit "/applicants/#{applicant.id}"

      expect(page).to have_content('Mike Dao')
  end
end
