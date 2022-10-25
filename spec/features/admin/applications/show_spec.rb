require 'rails_helper'

RSpec.describe 'Admin_Applications Show' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 6, breed: 'mix', name: 'Bobble', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "Pending")
    @app_2 = Application.create!(first: "Kevin", last: "Smith", street: "Street", city: "Any Town", state: "AnyState", zip: "12345", description: "Much dog!", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_1, application: @app_2)
  end
  describe 'When I visit /admin/applications/:id' do
    describe 'Then I see' do
      it 'the select application with its attributes' do
        visit "/admin/applications/#{@app_1.id}"

        expect(page).to have_content("Joe")
        expect(page).to have_content("Hilby")
        expect(page).to have_content("1234 N A St")
        expect(page).to have_content("Any Town")
        expect(page).to have_content("AnyState")
        expect(page).to have_content("12345")
        expect(page).to have_content("So cute!")
        expect(page).to have_content("Pending")
        expect(page).to have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
      end
      it 'a button to approve each individual pet in the application' do
        visit "/admin/applications/#{@app_1.id}"

        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
      end
    end

    describe 'When I click button "Approve" then I am' do
      it 'taken back to /admin/applications/:id' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Approve"

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      end

      it 'there is no button next to the approved pet' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Approve"

        expect(page).to_not have_button("Approve")
      end

      it 'there is an indicator next to the pet that they have been approved' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Approve"

        expect(page).to have_content("Approved")
      end
    end

    describe 'When I click button "Reject" then I am' do
      it 'taken back to /admin/applications/:id' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Reject"

        expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      end

      it 'there is no approve or reject button next to the pet' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Reject"

        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
      end

      it 'there is an indicator next to the pet that they have been rejected' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Reject"

        expect(page).to have_content("Rejected")
      end
    end

    describe "When there are two applications in the system for the same pet" do
      it 'When I approve one, I will not see any change on the other application' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Approve"
        visit "/admin/applications/#{@app_2.id}"

        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Approved")
        expect(page).to_not have_content("Rejected")
      end

      it 'When I reject one, I will not see any change on the other application' do
        visit "/admin/applications/#{@app_1.id}"
        click_button "Reject"
        visit "/admin/applications/#{@app_2.id}"

        expect(page).to have_button("Approve")
        expect(page).to have_button("Reject")
        expect(page).to_not have_content("Approved")
        expect(page).to_not have_content("Rejected")
      end
    end
  end

end