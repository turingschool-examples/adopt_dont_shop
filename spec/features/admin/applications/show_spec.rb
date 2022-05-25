require 'rails_helper'

RSpec.describe Application, type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
    @pet11 = @shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
    @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
    @pet13 = @shelter1.pets.create(name: 'Carter', age: 7, breed: 'Golden Retriever', adoptable: true)
    @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004", status: "Pending")
    @shelter2 = Shelter.create(name: 'Colorado Cats', city: 'Vail', foster_program: true, rank: 5)
    @pet21 = @shelter2.pets.create(name: 'Boots', age: 4, breed: 'Tabby', adoptable: true)
    @pet22 = @shelter2.pets.create(name: 'Evil Steve', age: 4, breed: 'Unknown', adoptable: false)
    @pet23 = @shelter2.pets.create(name: 'Huckleberry', age: 17, breed: 'Tuxedo', adoptable: true)
    @application2 = Application.create(name: 'Caden', street_address: '111 First Street', city: 'Denver', state: 'CO', zipcode: '07321')
    @petapplication1 = PetApplication.create(pet_id: "#{@pet11.id}", application_id: "#{@application1.id}")
    @petapplication2 = PetApplication.create(pet_id: "#{@pet12.id}", application_id: "#{@application1.id}")

    visit "/applications/#{@application1.id}"
  end

  context 'visiting the show page' do
    it 'clicking on each pets approve button approves pet and removes buttons from page' do
        expect(@petapplication1.status).to eq("Pending")
      within "#pet-#{@pet11.id}" do 
        click_on "Approve"
        
        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(@petapplication1.status).to eq("Approved")
        expect(page).to have_content("Approved")
        expect(page).to_not have_button("Approved")
        expect(page).to_not have_button("Reject")
        expect(page).to_not have_content("Rejected")
      end
    end

    it 'clicking on each pets approved button approves pet and removes buttons from page' do
        expect(@petapplication1.status).to eq("Pending")
      within "#pet-#{@pet11.id}" do 
        click_on "Reject"
      
        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(@petapplication1.status).to eq("Rejected")
        expect(page).to have_content("Rejected")
        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to_not have_content("Approved")
      end
    end
  end
end
