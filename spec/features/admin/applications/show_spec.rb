require 'rails_helper'

RSpec.describe Application, type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
    @pet11 = @shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
    @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
    @pet13 = @shelter1.pets.create(name: 'Carter', age: 7, breed: 'Golden Retriever', adoptable: true)
    @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004", status: "Pending")
    @shelter2 = Shelter.create(name: 'Colorado Cats', city: 'Vail', foster_program: true, rank: 5)
    @pet21 = @shelter2.pets.create(name: 'Boots', age: 4, breed: 'Tabby', adoptable: true)
    @pet22 = @shelter2.pets.create(name: 'Evil Steve', age: 4, breed: 'Unknown', adoptable: false)
    @pet23 = @shelter2.pets.create(name: 'Huckleberry', age: 17, breed: 'Tuxedo', adoptable: true)
    @application2 = Application.create(name: 'Caden', street_address: '111 First Street', city: 'Denver', state: 'CO', zipcode: '07321')
    @petapplication1 = PetApplication.create(pet_id: "#{@pet11.id}", application_id: "#{@application1.id}")
    @petapplication2 = PetApplication.create(pet_id: "#{@pet12.id}", application_id: "#{@application1.id}")
    @petapplication3 = PetApplication.create(pet_id: "#{@pet21.id}", application_id: "#{@application2.id}")


      visit "/admin/applications/#{@application1.id}"
  end

  it 'every pet on application has button to approve status and redirects back to admin application show page if clicked' do
    expect(page).to have_button("Approve #{@pet11.name}")
    expect(page).to have_button("Approve #{@pet12.name}")
    expect(page).to_not have_button("Approve #{@pet23.name}")
    click_button "Approve #{@pet11.name}"
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to_not have_button("Approve #{@pet11.name}")
    expect(page).to have_content("Approved Pets: #{@pet11.name}")
  end

  it 'denies pets if deny button is clicked and indication shows pet has been denied' do
    expect(page).to have_button("Deny #{@pet12.name}")
    click_button("Deny #{@pet12.name}")
    expect(current_path).to eq("/admin/applications/#{@application1.id}")
    expect(page).to_not have_button("Deny #{@pet12.name}")
    expect(page).to have_content("Denied Pets: #{@pet12.name}")
  end

  it 'approved or denied pets on one application do not affect another application' do
    click_button "Approve #{@pet11.name}"
    expect(page).to have_content("Approved Pets: #{@pet11.name}")
    visit "/admin/applications/#{@application2.id}"
  
    expect(page).to have_button("Approve #{@pet21.name}")
    expect(page).to have_button("Deny #{@pet21.name}")
    expect(page).to_not have_button("Approve #{@pet11.name}")
    expect(page).to_not have_content("Approved pets: #{@pet21.name}")
  end
end