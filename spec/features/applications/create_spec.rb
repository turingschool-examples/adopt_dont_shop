require 'rails_helper'

RSpec.describe 'Application creation' do
  before :each do
    @shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
    @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", description:"I love dogs and would be such a good dog mom", status: "In Progress")
    @pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
    @pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
    PetApplication.create!(pet: @pet1, application: @application1)
    PetApplication.create!(pet: @pet2, application: @application1)
  end

  describe 'As a visitor' do
    describe 'when I visit the pet index page' do
      it 'I see a link to start an application' do
        visit '/pets'

        expect(page).to have_link("Start an Application")
      end
    end

    describe 'when I click the "start an application" link' do
      it 'I am taken to the new application page where I see a form' do
        visit '/pets'
        click_on "Start an Application"

        expect(current_path).to eq('/application/new')
      end
    end

    describe 'when I fill in this form with my information, and I click submit' do
      it 'Then I am taken to the new applications show page' do
        visit '/application/new'

        fill_in 'name', with: "#{@application1.name}"
        fill_in 'street_address', with: "#{@application1.street_address}"
        fill_in 'city', with: "#{@application1.city}"
        fill_in 'zipcode', with: "#{@application1.zipcode}"
        fill_in 'description', with: "#{@application1.description}"

        click_on 'Submit'
        expect(current_path).to eq("/application/#{@application1.id}")
      end

      it 'and I see my name, address information, and description of why I would make a good home' do
        visit "/application/#{@application1.id}"

        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.zipcode)
        expect(page).to have_content(@application1.description)
      end

      it 'and I see an indicator that this application is "In Progress"' do
        visit "/application/#{@application1.id}"

        expect(page).to have_content("In Progress")
      end
    end
  end
end
