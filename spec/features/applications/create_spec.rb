require 'rails_helper'

RSpec.describe 'the pets index' do
  before :each do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )

    @shelter1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed: 'dog', name: 'Roofus')
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 12, breed: 'cat', name: 'Nacho')
    @pet3 = @shelter1.pets.create!(adoptable: false, age: 8, breed: 'bird', name: 'Big')

    @shelter2 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet5 = @shelter2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

    @app1.pets << @pet1
  end

  describe "Starting an Application" do
    describe 'when I visit the pet index page' do
      describe 'I see a link to Start an Application in Pet Index' do
        it 'has a link to Start an Application' do 
          visit "/pets"

          expect(page).to have_link("Start Adoption Application")
        end

        it 'when link is clicked, route to new application page' do
          visit "/pets"
          click_link "Start Adoption Application"

          expect(current_path).to eq("/applications/new")
        end
      end

      describe 'taken to the new application page where I see a form' do
        it 'form is present to fill in and a submit button (another test same as this in spec/features/applications/show_spec.rb)' do
          visit "/pets"
          click_link "Start Adoption Application"

          expect(page).to have_content("First Name")
          expect(page).to have_content("Last Name")
          expect(page).to have_content("Street Address")
          expect(page).to have_content("City")
          expect(page).to have_content("State")
          expect(page).to have_content("Zip Code")
          expect(page).to have_button("Submit")
        end

        it "Submit takes user to application's show page (another test same as this in spec/features/applications/show_spec.rb)" do
          visit "/pets"

          click_link "Start Adoption Application"

          fill_in 'First Name', with: 'Bruce'
          fill_in 'Last Name', with: 'Willis'
          fill_in 'Street Address', with: '9876 Miller Dr.'
          fill_in 'City', with: 'Whoville'
          fill_in 'State', with: 'KS'
          fill_in 'Zip Code', with: '54637'

          click_button 'Submit'

          expect(current_path).to eq("/applications/#{Application.last.id}")
        end
      end

      describe "When submit button on pet's index page is clicked" do
        it 'sees Name, address, and good home argument' do
          visit "/pets"
  
          click_link "Start Adoption Application"
  
          fill_in 'First Name', with: 'Bruce'
          fill_in 'Last Name', with: 'Willis'
          fill_in 'Street Address', with: '9876 Miller Dr.'
          fill_in 'City', with: 'Whoville'
          fill_in 'State', with: 'KS'
          fill_in 'Zip Code', with: '54637'
  
          click_button 'Submit'

          expect(page).to have_content("Bruce Willis")
          expect(page).to have_content("9876 Miller Dr.Whoville, KS 54637")
          expect(page).to have_content("Good Home Argument")
          expect(page).to have_content("In Progress")
        end
      end
    end
  end
end