require 'rails_helper'

RSpec.describe 'AdminShelters Index' do
  describe 'As an admin when I visit the Index page' do
    before(:each) do 
      @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
      @humaine = Shelter.create!(foster_program: true, name: 'Humaine Society', city: "Boulder", rank: 1)
      @snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
      @khoa = Application.create!(applicant_name: "Khoa", app_street: "Somewhere St", app_city: "Littleton", app_state: "CO", app_zip_code: "80121", description: "I am the best, duh", status: "Pending")
      @khoa.add_pet(@snugglez)
    end
    it 'I should see' do 
      visit '/admin/shelters'

      expect(@pound.name).to appear_before @humaine.name
    end

    it 'I should see' do 
      visit '/admin/shelters'

      expect(page).to have_content("Shelters With Pending Apps\nThe Pound")
       
    end
  end
end