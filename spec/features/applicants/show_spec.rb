# [ ] done

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe "Application Show Page" do
  before :each do
    @applicant_1 = Applicant.create!(
      name: "Bob",
      address: "123 Leaf Street",
      description: "Work from home",
      status: "In Progress"
    )

    @shelter_1 = Shelter.create!(
      foster_program: true,
      name: "Healthy Paws",
      city: "Denver",
      rank: 3
    )

    @pet_1 = @applicant_1.pets.create!(
      name: "Pepper",
      adoptable: true,
      age: 4,
      breed: "Pitbull",
      shelter_id: @shelter_1.id
    )

  end

  describe "User Story 1" do
    describe "User visits '/applicants/:id'" do
      it 'has applicant attributes' do
        visit "/applicants/#{@applicant_1.id}"

        save_and_open_page
        
        expect(page).to have_content(@applicant_1.name)
        expect(page).to have_content(@applicant_1.address)
        expect(page).to have_content(@applicant_1.description)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@applicant_1.status)
      end
    end
  end
end