require "rails_helper"
RSpec.describe 'Admin application show page' do
  
  describe 'Approving a pet' do
    before :each do
      mystery_shelter = Shelter.create(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9)
      scooby = mystery_shelter.pets.create(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true)
      ralph = mystery_shelter.pets.create(name: "Ralph", age: 12, breed: "Pyerneese", adoptable: true)
      frank = mystery_shelter.pets.create(name: "Frank", age: 3, breed: "Husky", adoptable: true)
      bilbo = mystery_shelter.pets.create(name: "Bilbo", age: 7, breed: "Golden Ret", adoptable: true)
      @bobby = Application.create(name: "Bobby Smith", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Pending")
      @joe = Application.create(name: "Joe", address: "4455 1st", city: "Denver", state: "CO", zipcode: "85555", description: "Im Awesome!", app_status: "Pending")
      PetApplication.create(pet: scooby, application: @bobby)
      PetApplication.create(pet: ralph, application: @bobby)
      PetApplication.create(pet: frank, application: @joe)
      PetApplication.create(pet: bilbo, application: @joe)


    end 
    it "has an approval button next to every " do
      visit "/admin/applications/#{@bobby.id}"
      save_and_open_page
      within("#pet-Scooby") do
        expect(page).to have_content('Scooby')
        click_button('Approve')
        expect(current_path).to eq("/admin/applications/#{@bobby.id}")
        expect(page).to_not have_content('Approve')
      end
      
      within("#pet-Ralph") do
        expect(page).to have_content('Ralph')
        expect(page).to have_content('Approve')
      end 
    end
  end

end
