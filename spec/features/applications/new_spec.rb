require 'rails_helper'

RSpec.describe 'Applications New' do 
  describe 'user_story_2' do 
    describe 'has a link to start and application' do 
      describe 'after clicking the link, it takes me to a new application page' do 
        it 'takes the applicant to the new applicaitons show page after filling out the form' do 
          shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
          pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

           visit "/pets"
          #  save_and_open_page

           expect(page).to have_link("Start an Application")

           click_link "Start an Application"

           fill_in("Name", with: "Joe Smith")
           fill_in("Street Address", with: "123 House")
           fill_in("City", with: "Denver")
           fill_in("State", with: "Colorado")
           fill_in("Zipcode", with: 80220)
           fill_in("Description", with: "I'm a good dog parent")
           click_button("Submit")
           new_application = Application.last
           
           expect(current_path).to eq("/applications/#{new_application.id}")
           expect(page).to have_content("#{new_application.name}")
        end

        it 'cannot create an artist without having all fields entered in the form' do 
          shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
          pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
          pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

           visit "/applications/new"
           click_button("Submit")
           new_application = Application.last
           expect(current_path).to eq("/applications/")
           expect(page).to have_content("Name can't be blank")
           expect(page).to have_content("Street address can't be blank")
           expect(page).to have_content("City can't be blank")
        end  
      end
    end
  end
end