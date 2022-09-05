require 'rails_helper'

RSpec.describe 'the applications show' do
  describe 'As a visitor' do
    before :each do
      @shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
      @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", status: "In Progress", description: "NO DESC[N/A]")
      @pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
    end

    describe 'when I visit an applications show page' do
      it 'I can see the name of the applicant' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@application1.name)
      end

      it 'I can see the full address of the applicant including street address, city, state, and zip code' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
        expect(page).to have_content(@application1.zipcode)
        expect(page).to have_content(@application1.description)
      end

      it 'I can see the names of all pets that this application is for (all names of pets should be links to their show page)' do
        PetApplication.create!(pet: @pet1, application: @application1)
        PetApplication.create!(pet: @pet2, application: @application1)
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)

        click_on "#{@pet1.name}"
        expect(current_path).to eq("/pets/#{@pet1.id}")
      end

      it 'I can see the Applications status, either "In Progress", "Pending", "Accepted", or "Rejected"' do
        visit "/applications/#{@application1.id}"

        expect(page).to have_content(@application1.status)
      end

        describe 'And that application has not been submitted' do
          it 'I can see a section on the page to "Add a Pet to this Application"' do
            visit "/applications/#{@application1.id}"

            expect(page).to have_content("Add a Pet to this Application")
          end

          it 'In that section I see an input where I can search for Pets by name' do
            visit "/applications/#{@application1.id}"

            expect(page).to have_content("Search")
            expect(page.has_field?).to eq(true)
          end
        end

        describe 'When I fill in this field with a Pets name and I click submit' do
          it 'I am taken back to the application show page and under the search bar I see any pet whose name matches my search' do
            visit "/applications/#{@application1.id}"

            fill_in 'query', with: "#{@pet1.name}"
            click_on 'Search'

            expect(current_path).to eq("/applications/#{@application1.id}/")
            within("#results") do
              expect(page).to have_content("#{@pet1.name}")
            end
          end

          it "I see a button to 'adopt this pet'" do
            visit "/applications/#{@application1.id}"

            fill_in 'query', with: "#{@pet1.name}"
            click_on 'Search'

            expect(page).to have_button("Adopt this pet")
          end

          it "When I click one of these buttons, then I am taken back to the application show page and I see the pet I want to adopt listed on this application" do
            visit "/applications/#{@application1.id}"

            fill_in 'query', with: "#{@pet1.name}"
            click_on 'Search'

            first(:button, "Adopt this pet").click

            expect(current_path).to eq "/applications/#{@application1.id}"

            within("#pets") do
              expect(page).to have_content(@pet1.name)
            end
          end

          it "I can add more than one pet" do
            visit "/applications/#{@application1.id}"

            fill_in 'query', with: "#{@pet1.name}"
            click_on 'Search'

            first(:button, "Adopt this pet").click

            fill_in 'query', with: "#{@pet2.name}"
            click_on 'Search'

            first(:button, "Adopt this pet").click

            within("#pets") do
              expect(page).to have_content(@pet1.name)
              expect(page).to have_content(@pet2.name)
            end
          end

          describe "I see a section to submit my application, I see an input to enter why I would be great for these pets" do
            it "when I fill in description and I click a button to submit an application then, I am taken back to the application show page" do
              visit "/applications/#{@application1.id}"

              fill_in 'query', with: "#{@pet1.name}"
              click_on 'Search'

              first(:button, "Adopt this pet").click

              expect(page.has_css?("#add_pet")).to eq true
              fill_in 'description', with: "I'm a great person"
              click_on 'Submit'

              expect(current_path).to eq "/applications/#{@application1.id}"
            end

            it "I see a indicator that the application is pending" do
              visit "/applications/#{@application1.id}"

              fill_in 'query', with: "#{@pet1.name}"
              click_on 'Search'

              first(:button, "Adopt this pet").click

              fill_in 'description', with: "I'm a great person"
              click_on 'Submit'

              expect(current_path).to eq "/applications/#{@application1.id}"

              expect(page).to have_content "Pending"
              expect(page.has_css?("#add_pet")).to eq false
            end

            it "When I visit a applications show page, I cannot submit my application without pets" do
              visit "/applications/#{@application1.id}"

              expect(page.has_css?("#submit_description")).to eq false
            end
          end
        end
      end
    end
  end
