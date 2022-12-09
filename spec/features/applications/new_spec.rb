require 'rails_helper'

RSpec.describe 'New Applications Page' do
  before(:each) do
    @aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @rgv = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @fancy = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @stop_n_shop = Shelter.create(name: 'Stop And Shop', city: 'Portland, ME', foster_program: true, rank: 2)

    @pirate = @aurora.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @aurora.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @aurora.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @taco = @aurora.pets.create(name: 'Taco', breed: 'Chihuahua', age: 2, adoptable: true)
    @bell = @aurora.pets.create(name: 'Bell', breed: 'Chihuahua', age: 2, adoptable: true)
    @charlie = @aurora.pets.create(name: 'Charlie', breed: 'sphynx', age: 2, adoptable: true)

    @joe = @rgv.pets.create(name: 'Joe', breed: 'bulldog', age: 2, adoptable: true)
    @kaity = @rgv.pets.create(name: 'Kaity', breed: 'Siamese', age: 8, adoptable: true)
    @bo = @rgv.pets.create(name: 'Bo', breed: 'Borzoi', age: 4, adoptable: true)

    @coony = @fancy.pets.create(name: 'Coony', breed: 'Maine Coon', age: 10, adoptable: true)
    @bloom = @fancy.pets.create(name: 'Irishman', breed: 'irish wolfhound', age: 2, adoptable: true)
  end
  
  describe '2. Starting an Application' do
    describe "the pet index page has link to 'Start an Application'" do
      it 'takes the user to the new application page' do
        visit pets_path

        click_link ('Start an Application')
        
        expect(current_path).to_not eq(pets_path)
        expect(current_path).to eq(applications_new_path)
      end
    end
    
    describe 'the new application page has a form, a submit link, and a cancel link' do
      before(:each)do
        visit applications_new_path
      end

      it "has 'Cancel' link that returns user to the pets index" do      
        click_link ('Cancel')

        expect(current_path).to_not eq(applications_new_path)
        expect(current_path).to eq(pets_path)
      end

      it 'has a field for all the attributes on the form' do
  
        expect(page).to_not have_field(:status)

        expect(page).to have_content("Please Complete This Application")
        expect(page).to have_field(:name)
        expect(page).to have_field(:street_address)
        expect(page).to have_field(:city)
        expect(page).to have_field(:state)
        expect(page).to have_field(:zip_code)
        expect(page).to have_field(:description)

      end

      describe 'INCOMPLETE APP: sends user back to the new application page if not completed when they hit submit (exception: :description)' do
        it 'displays the completed attribute info and flashes an unsucessful message' do
          #state left blank intentionally for testing

          expect(page).to have_content("Please Complete This Application")
          expect(page).to_not have_content('Unsuccessful - Please Try Again')
          expect(page).to_not have_field(:name, with: 'Song Sung Blue')
          expect(page).to_not have_field(:street_address, with: '99 Dead End Drive')
          expect(page).to_not have_field(:city,  with: 'Hopeless')
          expect(page).to_not have_field(:state, with: '')
          expect(page).to_not have_field(:zip_code, with: 54321)
          expect(page).to_not have_field(:description, with:'I aint got a friend for days')

          fill_in(:name, with: 'Song Sung Blue')
          fill_in(:street_address, with: '99 Dead End Drive')
          fill_in(:city,  with: 'Hopeless')
          fill_in(:state, with: '')
          fill_in(:zip_code, with: 54321)
          fill_in(:description, with: "I aint got a friend for days")
          
          click_button ("Submit")
          
          @new_app = Application.last
          expect(@new_app.nil?).to eq true

          expect(page).to have_content("Please Complete This Application")
          expect(page).to have_content('Unsuccessful - Please Try Again')
          expect(page).to have_field(:name, with: 'Song Sung Blue')
          expect(page).to have_field(:street_address, with: '99 Dead End Drive')
          expect(page).to have_field(:city,  with: 'Hopeless')
          expect(page).to have_field(:state, with: '')
          expect(page).to have_field(:description, with:'I aint got a friend for days')
        end
      end

      describe "FULLY COMPLETED APP: upon 'Submit', creates a record and routes user to the application show page" do
        before(:each) do
          fill_in(:name, with: 'Song Sung Blue')
          fill_in(:street_address, with: '99 Dead End Drive')
          fill_in(:city,  with: 'Hopeless')
          fill_in(:state, with: 'CO')
          fill_in(:zip_code, with: 54321)
          fill_in(:description, with: 'I aint got a friend for days')
          click_button ("Submit")
          
          @new_app = Application.last
        end

        it "saves the completed application show page once the submit link is clicked" do
          
          expect(@new_app.nil?).to eq false
          expect(@new_app.save).to eq true
          expect(@new_app.name).to eq('Song Sung Blue')
          expect(@new_app.street_address).to eq('99 Dead End Drive')
          expect(@new_app.city).to eq('Hopeless')
          expect(@new_app.state).to eq('CO')
          expect(@new_app.zip_code).to eq(54321)          
          expect(@new_app.description).to eq('I aint got a friend for days')
        end
        
        # it "displays all the information the user completed, status 'in progress', and a 'Successful' message on the application's show page" do
        #   expect(current_path).to_not eq(pets_path)
        #   expect(current_path).to_not eq(applications_new_path)
        #   expect(current_path).to eq("/applications/#{@new_app.id}")
        #   save_and_open_page
        #   expect(page).to have_content('Update Successful')
        #   expect(page).to have_content('Song Sung Blue')
        #   expect(page).to have_content('99 Dead End Drive')
        #   expect(page).to have_content('Hopeless')
        #   expect(page).to have_content('CO')
        #   expect(page).to have_content(54321)          
        #   expect(page).to have_content('I aint got a friend for days')
        # end
      end
    end
  end
end



