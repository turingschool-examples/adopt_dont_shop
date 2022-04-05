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
  
#   When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelter's with Pending Applications"
# And in this section I see the name of every shelter that has a pending application

  it "contains shelters with pending applications" do
    visit '/admin/shelters'
    expect(page).to have_content("Shelter's with Pending Applications")
  end
end
