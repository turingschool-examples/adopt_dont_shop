require "rails_helper"

RSpec.describe "the application show page", type: :feature do
  describe "shows the application" do

    before (:each) do
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @sammy = Pet.create!(adoptable: true, age: 1, breed: 'diluted calico', name: 'Sammy', shelter_id: @shelter.id)
      @smokie = Pet.create!(adoptable: true, age: 3, breed: 'tuxido', name: 'Smokie', shelter_id: @shelter.id)
      @application = Application.create!(name: 'Haewon Jeon',
                                        full_address: '305 Havard Dr., Fort Collins, CO 80212',
                                        description: "Because we are awesome",
                                        app_status: "pending")
      @application.pets << @sammy
      @application.pets << @smokie
    end

    it "with all attributes" do

      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.id)
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.full_address)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.app_status)
      expect(page).to have_content(@sammy.name)
      expect(page).to have_content(@smokie.name)

    end

    it "has all pets associated in links to individual pets" do
      visit "/applications/#{@application.id}"
      click_on "Sammy"
      expect(current_path).to eq("/pets/#{@sammy.id}")

      visit "/applications/#{@application.id}"
      click_on "Smokie"
      expect(current_path).to eq("/pets/#{@smokie.id}")
    end
  end
end


# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
