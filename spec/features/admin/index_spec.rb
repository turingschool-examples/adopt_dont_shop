require "rails_helper"

RSpec.describe "Admin index" do
  let!(:aurora) { Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }
  let!(:rgv) { Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5) }
  let!(:fancy_pets) { Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10) }

  it "displays all shelters in reverse alphabetical order by name" do
    visit "/admin/shelters"

    expect(page).to have_content("Aurora shelter")
    expect(page).to have_content("RGV animal shelter")
    expect(page).to have_content("Fancy pets of Colorado")

    expect("RGV animal shelter").to appear_before("Fancy pets of Colorado")
    expect("Fancy pets of Colorado").to appear_before("Aurora shelter")
  end
  

  it "contains section 'shelters with pending applications'" do
    visit '/admin/shelters'
    expect(page).to have_content("Shelter's with Pending Applications")
  end
  #   When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application
  
  it "contains shelters with pending applications" do
    @smith_app = Application.create!(name: "Bobby Smith", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Pending") 
    @jones_app = Application.create!(name: "Kim Jones", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Pending") 
    @adams_app = Application.create!(name: "Steve Adams", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "beats dogs!", app_status: "Rejected") 
    aurora = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) 
    shelter = Shelter.create(name: "Denver shelter", city: "Aurora, CO", foster_program: false, rank: 9) 
    @scooby = @smith_app.pets.create!(adoptable: true, age: 1, breed: "sphynx", name: "Scooby", shelter_id: shelter.id) 
    @scrappy = @smith_app.pets.create!(adoptable: true, age: 1, breed: "small dane", name: "Scrappy", shelter_id: shelter.id) 
    @bucky = @jones_app.pets.create!(adoptable: true, age: 1, breed: "small dane", name: "Bucky", shelter_id: shelter.id) 
    @roger = @adams_app.pets.create!(adoptable: true, age: 1, breed: "small dane", name: "Roger", shelter_id: aurora.id) 

    visit '/admin/shelters'
    save_and_open_page
    within("#shelters") do
      expect(page).to have_content("Denver shelter")
      expect(page).to_not have_content("Aurora shelter")
    end 
    
  end
end
