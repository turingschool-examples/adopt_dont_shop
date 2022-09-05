require 'rails_helper'

RSpec.describe 'the admin application show page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Humane Society', city: 'Humboldt CA', foster_program: true, rank: 4)
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, status: "Pending", description: "something")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, status: "Pending", description: "something")
    @pet_1 = @shelter_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Fran', age: 4, breed: 'French Bulldog', adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: 'Gilbert', age: 4, breed: 'Mutt', adoptable: true)
    @pet_app_1 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
    @pet_app_2 = ApplicationPet.create!(application: @app_2, pet: @pet_2)
    @pet_app_3 = ApplicationPet.create!(application: @app_2, pet: @pet_3)

  end

  it 'shows the pet applications based on application id' do
    visit "/admin/applications/#{@app_1.id}"

    expect(page).to have_content(@pet_app_1.pet.name)
    expect(page).to have_content(@pet_app_1.application.name)
    expect(page).to_not have_content(@pet_app_2.pet.name)
  end

  it 'shows an an approve button for that specific pet and when pressed changes status from pending to approved' do
    visit "/admin/applications/#{@app_1.id}"
    expect(@pet_app_1.application.status).to eq("Pending")
    expect(page).to have_button("Approve")
    click_button "Approve"
   
    # expect(@pet_app_1.application.status).to eq("Approved")
    expect(page).to have_content("Application status: Approved")
  end

  it 'does not display an Approve button after pet has already been approved' do
    visit "/admin/applications/#{@app_1.id}"
    click_button "Approve"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
  end

  it 'displays a Reject button that rejects a pet' do
    visit "/admin/applications/#{@app_1.id}"
    expect(page).to have_button("Reject")

    click_button "Reject"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
  end

  it 'does not effect other applications when rejected' do
    visit "/admin/applications/#{@app_1.id}"

    click_button "Reject"

    visit "/admin/applications/#{@app_2.id}"

    expect(page).to have_button("Reject")
    expect(page).to have_button("Approve")
  end

  it 'does not effect other applications when approved' do
    visit "/admin/applications/#{@app_1.id}"

    click_button "Approve"

    visit "/admin/applications/#{@app_2.id}"

    expect(page).to have_button("Reject")
    expect(page).to have_button("Approve")
  end

end
