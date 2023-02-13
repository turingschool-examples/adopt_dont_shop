require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do 
  Shelter.destroy_all 
  Application.destroy_all 
  Pet.destroy_all 
  PetApplication.destroy_all
  let!(:shelter1) {Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)}
  let!(:app1) {Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)}
  let!(:app2) {Application.create!(name: 'Timothy Timoth', street_address: "666 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )}
  let!(:pet2) {Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)}
  let!(:petapplication1) {PetApplication.create!(pet_id: pet1.id, application_id: app1.id)}
  let!(:petapplication2) {PetApplication.create!(pet_id: pet2.id, application_id: app1.id)}
  let!(:petapplication3) {PetApplication.create!(pet_id: pet2.id, application_id: app2.id)}

  describe 'When visiting admin application show page (/admin/applications/:id)' do 
    describe 'for every pet the application is for, there is a button to approve the application for specific pet' do
       it 'Can click button to approve specific pet and redirects to app show page' do 
        visit "/admin/applications/#{app1.id}"
          # save_and_open_page

        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)

        within("##{petapplication1.id}") do
          expect(page).to have_button("Approve this pet")

          first(:button, "Approve this pet").click

          expect(current_path).to eq("/admin/applications/#{app1.id}")
          # require 'pry'; binding.pry
          # expect(app1.status).to eq("Accepted")
          # expect(page).to have_content("#{pet1.name}: Approved")
        end
        visit "/admin/applications/#{app1.id}"
        # expect(petapplication1.application.status).to eq("Accepted")
        
       
         within('div.approved_pets') do 
            # expect(app1.status).to eq("Accepted")
            expect(page).to have_content("#{pet1.name}: Approved")
        #   expect(page).to have_content("#{pet1.name}: Approved") 
        #   expect(page).to_not have_content("#{pet2.name}: Approved")
         end

        # expect(page).to_not have_content("#{pet1.name}: Approve this pet")
         save_and_open_page
       end
    end
  end
end