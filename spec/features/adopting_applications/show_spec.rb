require 'rails_helper'

RSpec.describe 'adopting_applications show' do
  it "shows the applicant and all their attributes" do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)

    application = pet.adopting_applications.create(
                    full_name: 'Mike Piz', street_address: '13214 Yeet Rd.',
                    city: 'Cleveland', state: 'OH', zipcode: 18907,
                    description: 'I like this dog. It is very fluffy. Let me have it.',
                    in_progress: true, accepted: false, declined: false)
    visit "/adopting_applications/#{application.id}"

    expect(page).to have_content("Applicant: #{application.full_name}")
    expect(page).to have_content("City: #{application.city}")
    expect(page).to have_content("State: #{application.state}")
    expect(page).to have_content("Zipcode: #{application.zipcode}")
    expect(page).to have_content("Description: #{application.description}")
    expect(page).to have_content("Applying for: #{application.pet_name}")
    expect(page).to have_content("Application Status:")
    expect(page).to have_content("In Progress")
  end
end
