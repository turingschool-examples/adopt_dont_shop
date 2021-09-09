# spec/features/admin/applications/show_spec.rb

require 'rails_helper'

RSpec.describe 'admin applications show page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 8)
    @shelter_2 = Shelter.create!(name: 'Fort Collins Humane Society', city: 'Cheyenne', foster_program: true, rank: 2)
    @shelter_3 = Shelter.create!(name: 'Big Dogs Huge Paws', city: 'Fort Collins', foster_program: false, rank: 11)
    @pet_1 = @shelter_1.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: 'Bianca', age: 3, breed: 'Great Pyrenees',  adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Chibi', age: 10, breed: 'Shiba Inu', adoptable: true)
    @app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
    @app_2 = Application.create!(
      name: "Doug Olson",
      address: "2866 Villalobos Ave",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
  end

  it "can approve a pet adoption" do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    within "##{@pet_1.name}" do
      click_button 'Approve'
    end
      expect(current_path).to eq("/admin/applications/#{@app_1.id}")
      expect(page).to have_content("Approved")
  end

  it "can decline a pet adoption" do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/applications/#{@app_1.id}"

    within "##{@pet_1.name}" do
      click_button 'Reject'
    end

    expect(current_path).to eq("/admin/applications/#{@app_1.id}")
    expect(page).to have_content("Rejected")
  end

  it "doesn't show option to adopt pet already approved" do
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2
    @app_2.pets << @pet_1
    @app_2.pets << @pet_2


    visit "/admin/applications/#{@app_1.id}"

    within "##{@pet_1.name}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/applications/#{@app_1.id}")

    visit "/admin/applications/#{@app_2.id}"

    within "##{@pet_1.name}" do
      click_button 'Approve'
    end
    
    expect(current_path).to eq("/admin/applications/#{@app_2.id}")
    expect(page).to have_content("Approved")
  end
end
