require 'rails_helper'

RSpec.describe "Applicant Show" do
  before(:each)do 
    @olivia = Applicant.create!(name: "Olivia Valentin",
                                street: "1234 Main St",
                                city: "Denver",
                                state: "CO",
                                zip: "80203",
                                good_home: "I have vetenarian expierence")

    @shelter = Shelter.create!(name: 'Aurora shelter', 
                               city: 'Aurora, CO', 
                               foster_program: false, 
                               rank: 9)

    @pet_1 = Pet.create(adoptable: true,
                        age: 1, 
                        breed: 'sphynx', 
                        name: 'Lucille Bald', 
                        shelter_id: @shelter.id)

    @pet_2 = Pet.create(adoptable: true, 
                        age: 3, 
                        breed: 'doberman', 
                        name: 'Lobster', 
                        shelter_id: @shelter.id)

    PetApplicant.create!(applicant: @olivia,
                         pet: @pet_1)

    PetApplicant.create!(applicant: @olivia,
                         pet: @pet_2)
  end
  
  it "shows applicant's attributes" do
    visit "/applicants/#{@olivia.id}"

    expect(page).to have_content("#{@olivia.name}")
    expect(page).to have_content("#{@olivia.street}")
    expect(page).to have_content("#{@olivia.city}")
    expect(page).to have_content("#{@olivia.state}")
    expect(page).to have_content("#{@olivia.good_home}")
    expect(page).to have_content("#{@olivia.status}")
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_2.name}")
  end
  
  it "has link to each pet's show page" do
    visit "/applicants/#{@olivia.id}"

    click_link "#{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applicants/#{@olivia.id}"

    click_link "#{@pet_2.name}"

    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
  describe "Add a Pet to this Application" do
    it "I see a section to search for a pet by name. When I fill the
        search bar, then I click submit, I am taken to '/applicaiton/:id' page
        where I see any pet names that my search" do

      shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
      heather = Applicant.create(name: "Heather", street: "pearl st", city: "denver", state: "CO", zip: "80203", good_home: "live close to dog parks")
      visit "/applicants/#{heather.id}"

      expect(page).to have_content("Add a Pet to this Application")
      fill_in :search_name, with: "Scooby"
      
      click_on "Search" 
      
      expect(current_path).to eq("/applicants/#{heather.id}") 
      save_and_open_page
      
      expect(page).to have_content(scooby.name)
    end
  end
end
# Searching for Pets for an Application
# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search