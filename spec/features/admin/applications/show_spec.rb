require 'rails_helper'

RSpec.describe 'Applications show page:' do
  before(:each) do
    @application_2 = Application.create!(first_name: "Sam", last_name: "Smith", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, status: "Pending")
    @application_1 = Application.create!(first_name: "Jon", last_name: "Duttko", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, home_description: "friendly", status: "Pending")
    @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)

    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(name: 'Indy', age: 4, breed: 'Mutt', adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = Pet.create(name: 'Tony', age: 128, breed: 'Tortoise', adoptable: true, shelter_id: @shelter_1.id)
    @application_2.pets << @pet_3
    @application_2.pets << @pet_2
    visit "/admin/applications/#{@application_2.id}"
  end

  describe 'As an admin, when I visit an application show page' do
    it 'For every pet that the application is for, I see a button to approve the application for that specific pet' do
      expect(page).to have_button("Approve #{@pet_3.name}'s Adoption")
      expect(page).to have_content("#{@application_2.first_name}")
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_content("#{@pet_3.name}")

      expect(page).to_not have_content("#{@application_1.first_name}")
      expect(page).to_not have_content("#{@pet_1.name}")
    end
  end

  describe 'When I click the button to approve adoption of a pet' do
    before(:each) do
      click_on "Approve #{@pet_3.name}'s Adoption"
    end
    it 'takes me back to the admin application show page' do
      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
    end

    it 'I no longer see a button to approve that pet' do
      expect(page).to_not have_button("Approve #{@pet_3.name}'s Adoption")
    end

    it 'I instead see an indication that the pet application has been approved' do
      expect(page).to have_content("#{@pet_3.name}'s adoption was approved!")
    end
  end

  describe 'When I click the button to reject adoption of a pet' do
    before(:each) do
      click_on "Reject #{@pet_2.name}'s Adoption"
    end
    it 'takes me back to the admin application show page' do
      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
    end

    it 'I no longer see a button to reject that pet' do
      expect(page).to_not have_button("Reject #{@pet_2.name}'s Adoption")
    end

    it 'I instead see an indication that the pet application has been rejected' do
      expect(page).to have_content("#{@pet_2.name}'s adoption was rejected")
    end
  end
end
