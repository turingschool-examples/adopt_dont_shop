require 'rails_helper'

RSpec.describe 'the admin applications show page' do
 describe "For each pet on the app I see a button to approve the application" do
    it "Has a button to approve each pet" do
      happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")

      fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)
      visit "/admin/applications/#{samantha_application.id}"
      expect(page).to have_button("Approve This Pet")
    end

    it 'when I click that button I am taken back to the application show page' do
      happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")

      fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)

      visit "/admin/applications/#{samantha_application.id}"

      within("#pet_#{fluffy.id}") do
        click_button("Approve This Pet")
      end
      expect(current_path).to eq("/admin/applications/#{samantha_application.id}")
    end

    it 'when I click that button I am taken back to the application show page & I do not see a buton to approve the pet' do
      happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")

      fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)

      visit "/admin/applications/#{samantha_application.id}"

      within("#pet_#{fluffy.id}") do
      click_button("Approve This Pet")
      end

      expect(current_path).to eq("/admin/applications/#{samantha_application.id}")

      expect(page).to_not have_content("Approve This Pet")
    end

    it "And instead I see an indicator next to the pet that they have been approved" do

      happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")

      fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)

      visit "/admin/applications/#{samantha_application.id}"
      within("#pet_#{fluffy.id}") do
      click_button("Approve This Pet")
      end

      expect(current_path).to eq("/admin/applications/#{samantha_application.id}")

      expect(page).to have_content("Approved")

    end

  end

  describe "For each pet on the app I see a button to reject the application" do
    before :each do
      @happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @fluffy = @happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")
      @melissa_application = Application.create!(first_name: "Melissa", last_name: "Johnson", street_address: "123 Potato Street", city: "Denver", state: "CO", zip_code: 19462, description: "I would like this dog.", status: "Pending")

      @fluffy_application = PetApplication.create!(pet: @fluffy, application: @samantha_application)
      @fluffy_application2 = PetApplication.create!(pet: @fluffy, application: @melissa_application)
    end
    
     it "Has a button to reject each pet" do

       visit "/admin/applications/#{@samantha_application.id}"

       expect(page).to have_button("Reject This Pet")
     end

     it 'when I click that button I am taken back to the application show page' do

       visit "/admin/applications/#{@samantha_application.id}"

       click_button('Reject This Pet')

       expect(current_path).to eq("/admin/applications/#{@samantha_application.id}")
     end

     it 'when I click that button I am taken back to the application show page & I do not see a buton to reject the pet' do
       visit "/admin/applications/#{@samantha_application.id}"

       within("#pet_#{@fluffy.id}") do
         click_button('Reject This Pet')

         expect(page).to_not have_button("Reject This Pet")
       end
     end

     it "And instead I see an indicator next to the pet that they have been rejected" do
       visit "/admin/applications/#{@samantha_application.id}"

       within("#pet_#{@fluffy.id}") do
         click_button('Reject This Pet')

         expect(page).to have_content("Rejected")
       end
     end

     it "Accepting/Rejecting one application does not affect the other application for the same pet" do
      visit "/admin/applications/#{@samantha_application.id}"

      within("#pet_#{@fluffy.id}") do
        click_button('Reject This Pet')

        expect(page).to have_content("Rejected")
      end

      visit "/admin/applications/#{@melissa_application.id}"

      expect(page).to have_button("Reject This Pet")
      expect(page).to have_button("Approve This Pet")

      within("#pet_#{@fluffy.id}") do
        click_button('Reject This Pet')
      end

      expect(page).to have_content("Rejected")
    end
   end

   describe 'application approval' do
     before :each do
      @happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @saving_pets_shelter = Shelter.create!(name: "Saving Pets Shelter", foster_program: true, city: "New York", rank: 3)

      @fluffy = @happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @butters = @saving_pets_shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")

      @samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like these dogs for these reasons.", status: "Pending")

      @fluffy_application = PetApplication.create!(pet: @fluffy, application: @samantha_application)
      @butters_application = PetApplication.create!(pet: @butters, application: @samantha_application)
     end

     it 'should redirect to the admin application show page if all pets are approved' do
      visit "/admin/applications/#{@samantha_application.id}"

      within("#pet_#{@fluffy.id}") do
        click_button("Approve This Pet")
      end

      within("#pet_#{@butters.id}") do
        click_button("Approve This Pet")
      end

      expect(current_path).to eq("/admin/applications/#{@samantha_application.id}")
     end

     xit 'should approve application if all pets are approved' do
      visit "/admin/applications/#{@samantha_application.id}"

      expect(page).to have_content("Application Status: Pending")

      within("#pet_#{@fluffy.id}") do
        click_button("Approve This Pet")
      end

      within("#pet_#{@butters.id}") do
        click_button("Approve This Pet")
      end

      expect(page).to have_content("Application Status: Approved")
     end
   end
end
