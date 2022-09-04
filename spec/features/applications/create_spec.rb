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

        expect(page).to have_button("Start an Application")
      end
    end

    describe 'when I click the "start an application" button' do
      it 'I am taken to the new application page where I see a form' do
        visit '/pets'
        click_on "Start an Application"

        expect(current_path).to eq('/applications/new')
      end
    end

    describe 'when I fill in this form with my information, and I click submit' do
      it 'Then I am taken to the new applications show page' do
        visit '/applications/new'

        fill_in 'name', with: "Joe"
        fill_in 'street_address', with: "4545 Cool St."
        fill_in 'city', with: "Miami"
        fill_in 'state', with: "FL"
        fill_in 'zipcode', with: "11111"
        fill_in 'description', with: "I'm pretty great."

        click_on 'Submit'

        expect(current_path).to eq("/applications/#{Application.last.id}")
      end

      it 'and I see my name, address information, and description of why I would make a good home' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
        expect(page).to have_content(@application1.zipcode)
        expect(page).to have_content(@application1.description)
      end

      it 'and I see an indicator that this application is "In Progress"' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content("In Progress")
      end
    end

    describe 'when I fail to fill in any of the form fields and I click submit' do
      it 'Then I am taken back to the new applications page and I see a message that I must fill in those forms' do
        visit '/applications/new'

        fill_in 'name', with: "Joe"
        #'street_address' is not filled in
        fill_in 'city', with: "Miami"
        fill_in 'state', with: "FL"
        fill_in 'zipcode', with: "11111"
        fill_in 'description', with: "I'm pretty great."

        click_on 'Submit'

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Application not submitted: Required information missing.")
        expect(Application.count).to eq(1) #no new application was created
      end
    end
  end
end
