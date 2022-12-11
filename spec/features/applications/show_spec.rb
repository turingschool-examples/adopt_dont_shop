require 'rails_helper'

RSpec.describe "Show spec" do
  before :each do
    @shelter1 = Shelter.create!(foster_program: true, name: "Denver Animal Shelter", city: "Denver", rank: 1)
    @shelter2 = Shelter.create!(foster_program: false, name: "Charlotte Dog Catchers", city: "Charlotte", rank: 12)
    
    @pet1 = Pet.create!(adoptable: true, age: 3, breed: "dog", name: "Luca", shelter_id: @shelter1.id)
    @pet2 = Pet.create!(adoptable: true, age: 15, breed: "dog", name: "Sebastian", shelter_id: @shelter1.id)
    @pet3 = Pet.create!(adoptable: true, age: 5, breed: "cat", name: "Charles", shelter_id: @shelter1.id)
    
    @pet4 = Pet.create!(adoptable: false, age: 12, breed: "dog", name: "Paul", shelter_id: @shelter1.id)
    @pet5 = Pet.create!(adoptable: true, age: 5, breed: "cat", name: "Maggie", shelter_id: @shelter2.id)

    @application1 = Application.create!(last: "Banos", first: "Leo", street: "123 1st St", city: "Denver", state: "CO", zip:"24135", description: "I am good parent", status: "Pending")
    @application2 = Application.create!(last: "Lampke", first: "William", street: "456 2nd St", city: "Charlotte", state: "NC", zip:"24451", description: "I am great parent", status: "In Progress")

    @application3 = Application.create!(last: "fake", first: "iam", street: "123 1st St", city: "Denver", state: "CO", zip:"24135", description: "I am good parent", status: "Pending")


    @ap1 = ApplicationPet.create!(application_id: @application1.id, pet_id: @pet1.id, status: true)
    @ap2 = ApplicationPet.create!(application_id: @application2.id, pet_id: @pet2.id, status: false)
  end
  describe 'show' do
    it 'shows information on a specific application' do
      visit "/applications/#{@application1.id}"

      save_and_open_page
      expect(page).to have_content("Leo Banos")
      expect(page).to have_content("123 1st St Denver, CO 24135")
      expect(page).to have_content(@application1.description)
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@application1.status)
    end
  end
  describe 'add pet' do
    it 'has a search bar that lets you search pets' do
      visit "/applications/#{@application3.id}"
      fill_in :petsearch, with: "Charles"
      click_on "Submit"
      expect(page).to have_content("Charles")
    end
  end

  describe 'adopt this pet' do
    it 'add pets from the search bar' do
      visit "/applications/#{@application3.id}"
      fill_in :petsearch, with: "Charles"
      click_on "Submit"
     
      click_on "Add #{@pet3.name}"
      expect(page).to have_content("Pets on Application: Charles")
    end
  end
end