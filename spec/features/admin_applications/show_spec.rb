require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do 
  Shelter.destroy_all 
  Application.destroy_all 
  Pet.destroy_all 
  PetApplication.destroy_all
 
  describe 'When visiting admin application show page (/admin/applications/:id)' do 
    describe 'for every pet the application is for, there is a button to approve the application for specific pet' do
       it 'Can click button to approve specific pet and redirects to app show page' do
          shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
          app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
          app2 = Application.create!(name: 'Timothy Timoth', street_address: "666 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
          pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
          pet2 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)
          pet3 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Gabe', shelter_id: shelter1.id,)
          petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id, status: "In Progress")
          petapplication2 = PetApplication.create!(pet_id: pet2.id, application_id: app1.id, status: "In Progress")
          petapplication3 = PetApplication.create!(pet_id: pet3.id, application_id: app1.id, status: "In Progress")
          petapplication4 = PetApplication.create!(pet_id: pet2.id, application_id: app2.id, status: "In Progress")
        visit "/admin/applications/#{app1.id}"

        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)
      
        # ============== ACCEPT PET 1 ==================

        within("##{petapplication1.id}") do
          expect(page).to have_selector(:link_or_button, "Approve #{petapplication1.pet.name}")
          click_button("Approve #{petapplication1.pet.name}")
          expect(current_path).to eq("/admin/applications/#{app1.id}")
        end

        within('div.approved_pets') do 
          expect(page).to have_content("#{pet1.name}: Approved")
        end

        #  save_and_open_page

      #================ ACCEPT PET 2 ===================
        within("##{petapplication2.id}") do
          click_button("Approve #{petapplication2.pet.name}")
          expect(current_path).to eq("/admin/applications/#{app1.id}")
        end

         within('div.approved_pets') do 
          expect(page).to have_content("#{pet2.name}: Approved")
        end

        #  save_and_open_page

        #================ REJECT PET 3 ===================
          within("##{petapplication3.id}") do
          click_button("Reject this pet for adoption")
          expect(current_path).to eq("/admin/applications/#{app1.id}")
        end

         within('div.approved_pets') do 
          expect(page).to_not have_content("#{pet3.name}: Approved")
        end
        # save_and_open_page
      end
    end
  end
end