require 'rails_helper'

RSpec.describe 'the applicants show' do
  before :each do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: 'Pending')
    @pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  end

  describe 'as a admin' do
    describe 'Approving a Pet for Adoption' do
      it "For every pet that the application is for, I see a button to approve the application for that specific pet" do

        visit "/admin/applicants/#{@applicant.id}"

        expect(page).to have_content(@pet.name)
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_button("Approve Adoption for Scooby")
        expect(page).to have_button("Approve Adoption for Jake")
      end

      it "When I click that button, I'm taken back to the admin application show page" do

        visit "/admin/applicants/#{@applicant.id}"

        click_on("Approve Adoption for Scooby")
        expect(current_path).to eq("/admin/applicants/#{@applicant.id}")

      end

      it "Next to the pet that I approved, I do not see a button to approve this pet, instead I see an indicator next to the pet that they have been approved" do
        visit "/admin/applicants/#{@applicant.id}"

        click_on("Approve Adoption for Scooby")

        expect(page).to have_content("Adoption Aprroved for #{@pet.name}")
        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_button("Approve Adoption for Scooby")
        expect(page).to have_button("Approve Adoption for Jake")

      end
    end

    describe 'Rejecting a Pet for Adoption' do
      it "For every pet that the application is for, I see a button to reject the application for that specific pet" do

        visit "/admin/applicants/#{@applicant.id}"

        expect(page).to have_content(@pet.name)
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_button("Reject Adoption for Scooby")
        expect(page).to have_button("Reject Adoption for Jake")
      end

      it "When I click that button, I'm taken back to the admin application show page" do

        visit "/admin/applicants/#{@applicant.id}"

        click_on("Reject Adoption for Scooby")
        expect(current_path).to eq("/admin/applicants/#{@applicant.id}")
      end

      it "Next to the pet that I Rejected, I do not see a button to reject or approve this pet, instead I see an indicator next to the pet that they have been rejected" do
        visit "/admin/applicants/#{@applicant.id}"

        click_on("Reject Adoption for Scooby")

        expect(page).to have_content("Adoption Rejected for #{@pet.name}")
        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_button("Reject Adoption for Scooby")
        expect(page).to_not have_button("Approve Adoption for Scooby")
        expect(page).to have_button("Reject Adoption for Jake")
        expect(page).to have_button("Approve Adoption for Jake")

      end
    end
  end
end
