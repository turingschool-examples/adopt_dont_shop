require 'rails_helper'

RSpec.describe "Applicant Show" do
  before(:each)do 
    @olivia = Applicant.create!(name: "Olivia Valentin",
                                street: "1234 Main St",
                                city: "Denver",
                                state: "CO",
                                zip: "80203")

    @shelter = Shelter.create!(name: 'Aurora shelter', 
                               city: 'Aurora, CO', 
                               foster_program: false, 
                               rank: 9)

    @pet_1 = Pet.create!(adoptable: true,
                        age: 1, 
                        breed: 'sphynx', 
                        name: 'Lucille Bald', 
                        shelter_id: @shelter.id)

    @pet_2 = Pet.create!(adoptable: true, 
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
    before :each do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
      @heather = Applicant.create(name: "Heather", street: "pearl st", city: "denver", state: "CO", zip: "80203")
    end

    it "has a search bar for a pet by name, that displays any pet names that matches the search" do
      visit "/applicants/#{@heather.id}"

      expect(page).to have_content("Add a Pet to this Application")
      fill_in :search_name, with: "Scooby"
      
      click_on "Search" 

      expect(current_path).to eq("/applicants/#{@heather.id}") 
      expect(page).to have_content(@scooby.name)
    end

    it 'can add a searched pet to an application' do 
      visit "/applicants/#{@heather.id}"

      expect(page).to_not have_content("Adopt this Pet")

      fill_in :search_name, with: "Scooby"
      click_on "Search"
      click_on "Adopt this Pet"

      expect(current_path).to eq("/applicants/#{@heather.id}")
      expect(page).to have_content("#{@heather.pets.name}")
    end
  end

  describe "Application pending" do
      it "I see input to enter good home, submits application after filling form,
          status changes to pending." do
        visit "/applicants/#{@olivia.id}"
       
        expect(@olivia.good_home).to eq(nil)
        expect(page).to have_field(:good_home)
        expect(page).to have_button("Submit Application")
        
        fill_in :good_home, with: "to save lives"
        click_on "Submit Application"
        
        expect(current_path).to eq("/applicants/#{@olivia.id}")
        expect(page).to have_content("Pending")

        expect(page).to_not have_link("Submit Application")
        expect(page).to_not have_link("Adopt this Pet")
        expect(page).to_not have_link("Search")
        expect(page).to have_content(@olivia.good_home)
        expect(page).to have_content("Description of why You would make a Good Home:")
    end
  end
  
  describe "visit applicant with no pets added" do
    before :each do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
      @heather = Applicant.create(name: "Heather", street: "pearl st", city: "denver", state: "CO", zip: "80203")
    end
    it "No pets added, I do not see submit application" do
      visit "/applicants/#{@heather.id}"

      expect(page).to_not have_link("Submit Application")
    end
  end
  describe "Search for partial matches" do
    it "When I search scooby, I see pets: scooby, scooby doobie, 
        and scooby doobie doo" do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @scooby = Pet.create(name: 'scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
      @scoobydoob = Pet.create(name: 'scooby doobie', age: 3, breed: 'Golden Retriever', adoptable: true, shelter_id: @shelter_1.id)
      @scoobydoobiedoo = Pet.create(name: 'scooby doobie doo', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
      @heather = Applicant.create(name: "Heather", street: "pearl st", city: "denver", state: "CO", zip: "80203")
    
      visit "/applicants/#{@heather.id}"

      fill_in :search_name, with: "scooby"
      click_on "Search"
      expect(page).to have_content(@scooby.name)
      expect(page).to have_content(@scoobydoob.name)
      expect(page).to have_content(@scoobydoobiedoo.name)
    end

    it "Case Insensitivity check when I search fluff, I see Fluffy, FLUFF, Mr. Fluff" do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @fluffy = Pet.create(name: 'Fluffy', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
      @fluff = Pet.create(name: 'FLUFF', age: 3, breed: 'Golden Retriever', adoptable: true, shelter_id: @shelter_1.id)
      @mr_fluff = Pet.create(name: 'Mr. Fluff', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
      @heather = Applicant.create(name: "Heather", street: "pearl st", city: "denver", state: "CO", zip: "80203")
      
      visit "/applicants/#{@heather.id}"

      fill_in :search_name, with: "fluff"
      click_on "Search"
      expect(page).to have_content(@fluff.name)
      expect(page).to have_content(@fluffy.name)
      expect(page).to have_content(@mr_fluff.name) 
    end
  end
end
