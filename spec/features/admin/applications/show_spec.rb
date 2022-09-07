require 'rails_helper'

RSpec.describe 'Admin application show page' do
  before :each do
    @shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
    @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", status: "Pending", description: "NO DESC[N/A]")
    @pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
    @pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
    PetApplication.create!(pet: @pet1, application: @application1)
    PetApplication.create!(pet: @pet2, application: @application1)
  end
  describe 'As a admin' do
    describe 'When I visit an admin application show page ("/admin/applications/:id")' do
      it 'For every pet that the application is for, I see a button to approve the application for that specific pet' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          expect(page).to have_button("Approve Pet")
        end

        within("#pet-#{@pet2.id}") do
          expect(page).to have_button("Approve Pet")
        end
      end

      it 'When I click that button, then I am taken back to the admin application show page' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Approve Pet"
        end

        expect(current_path).to eq("/admin/applications/#{@application1.id}")
      end

      it 'Next to the pet that I approved, I do not see a button to approve this pet' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Approve Pet"
        end

        within("#pet-#{@pet1.id}") do
          expect(page).to_not have_button("Approve Pet")
          expect(page).to have_content("You have been approved for #{@pet1.name}")
        end

        within("#pet-#{@pet2.id}") do
          expect(page).to have_button("Approve Pet")
        end
      end

      it 'And instead I see an indicator next to the pet that they have been approved' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Approve Pet"
        end

        within("#pet-#{@pet1.id}") do
          expect(page).to have_content("You have been approved for #{@pet1.name}")
        end
      end

      it 'For every pet that the application is for, I see a button to reject the application for that specific pet' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          expect(page).to have_button("Reject Pet")
        end

        within("#pet-#{@pet2.id}") do
          expect(page).to have_button("Reject Pet")
        end
      end

      it "When I click that button I am then taken back to the admin application show page" do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Reject Pet"
        end

        expect(current_path).to eq("/admin/applications/#{@application1.id}")
      end

      it 'Next to the pet that I rejected, I do not see a button to approve or reject this pet and instead I see an indicator next to the pet that they have been rejected' do
        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Reject Pet"
        end

        within("#pet-#{@pet1.id}") do
          expect(page).to_not have_button("Approve Pet")
          expect(page).to_not have_button("Reject Pet")
          expect(page).to have_content("You have been rejected for #{@pet1.name}")
        end

        within("#pet-#{@pet2.id}") do
          expect(page).to have_button("Approve Pet")
          expect(page).to have_button("Reject Pet")
          click_on "Approve Pet"
        end

        within("#pet-#{@pet1.id}") do
          expect(page).to have_content("You have been rejected for #{@pet1.name}")
        end
      end

      it 'should not effect other applications with two applicants are rejected or approved for the same pet' do
        @application2 = Application.create!(name:"Dominic OD", street_address:"2250", city:"Frisco", state:"Texas", zipcode:"75034", status: "Pending", description: "NO DESC[N/A]")
        PetApplication.create!(pet: @pet1, application: @application2)
        visit "/admin/applications/#{@application2.id}"

        within("#pet-#{@pet1.id}") do
          click_on "Reject Pet"
        end

        visit "/admin/applications/#{@application1.id}"

        within("#pet-#{@pet1.id}") do
          expect(page).to have_button("Approve Pet")
          expect(page).to have_button("Reject Pet")
          click_on "Approve Pet"
        end

        visit "/admin/applications/#{@application2.id}"

        within("#pet-#{@pet1.id}") do
          expect(page).to have_content("You have been rejected for #{@pet1.name}")
        end
      end
    end
  end
end
