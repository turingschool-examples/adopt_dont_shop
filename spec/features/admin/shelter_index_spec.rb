require 'rails_helper'

RSpec.describe "/admin/shelters" do
  before do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
    @shelter_2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Sky City", rank: 30)
    @shelter_3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Sky City", rank: 40)
    @shelter_4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Sky City", rank: 50)
    @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
    @pet_2 = @shelter_2.pets.create!(name: "Bento", age: 23, breed: "dog")
    @pet_3 = @shelter_3.pets.create!(name: "Quiggle", age: 555,)
    @pet_4 = @shelter_4.pets.create!(name: "Simpleton", age: 80,)
    @pet_5 = @shelter_1.pets.create!(name: "Snapchat", age: 799,)
    @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
    @application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
    @application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Approved")
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
    PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id)
    PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id)
  end

  it 'lists all shelter names that have been created' do
    visit "admin/shelters" 
    within("#all_shelters") do
      expect(page).to have_content("Taj Mahal for Dogs")
      expect(page).to have_content("Valhalla for Cats")
      expect(page).to have_content("Alexandria for Squirrels")
      expect(page).to have_content("Shangri La for Turtles")
    end
  end

  it "has a section for only shelters with open applications" do
    visit "admin/shelters"  
    
    within("#open_app_shelters") do
      expect(page).to have_content("Shelters with open applications")
      expect(page).to have_content("Valhalla for Cats")
      expect(page).to have_content("Shangri La for Turtles")
      expect(page).to have_no_content("Taj Mahal for Dogs")
      expect(page).to have_no_content("Alexandria for Squirrels")
    end
  end

  it 'sorts shelters by reverse alphabetical order by name' do
    visit "admin/shelters" 
    
    within("#all_shelters") do
      expect(@shelter_2.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to appear_before(@shelter_4.name)
      expect(@shelter_4.name).to appear_before(@shelter_3.name)
    end
  end

  it "sorts open shelters in alphabetical order by name" do
    @shelter_5 = Shelter.create!(foster_program: true, name: "elephantine", city: "Haberdashery", rank: 40)
    @shelter_6 = Shelter.create!(foster_program: true, name: "beryllium", city: "jubilant", rank: 40)
    @shelter_7 = Shelter.create!(foster_program: true, name: "Diaphenous", city: "Gimble", rank: 40)
    @shelter_8 = Shelter.create!(foster_program: true, name: "Concatinate", city: "Fantastic", rank: 40)
    @pet_10 = @shelter_5.pets.create!(name: "sdf", age: 799)
    @pet_11 = @shelter_6.pets.create!(name: "wer", age: 799)
    @pet_12 = @shelter_7.pets.create!(name: "dfg", age: 799)
    @pet_13 = @shelter_8.pets.create!(name: "fgh", age: 799)
    @application_8 = Application.create!(applicant_name: "rtb", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
    @application_9 = Application.create!(applicant_name: "hgn", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Pending")
    @application_10 = Application.create!(applicant_name: "xdg", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Pending")
    @application_11 = Application.create!(applicant_name: "ine", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Pending")
    PetApplication.create!(pet_id: @pet_10.id, application_id: @application_8.id)
    PetApplication.create!(pet_id: @pet_11.id, application_id: @application_9.id)
    PetApplication.create!(pet_id: @pet_12.id, application_id: @application_10.id)
    PetApplication.create!(pet_id: @pet_13.id, application_id: @application_11.id)
    visit "admin/shelters" 
    
    within("#open_app_shelters") do
      expect(@shelter_6.name).to appear_before(@shelter_8.name)
      expect(@shelter_8.name).to appear_before(@shelter_7.name)
      expect(@shelter_7.name).to appear_before(@shelter_5.name)
    end
  end

  it "has a shelter names are a link to that shelter" do
    visit "admin/shelters"
   
    expect(page).to have_link("Taj Mahal for Dogs", :href => "/admin/shelters/#{@shelter_1.id}")
    expect(page).to have_link("Valhalla for Cats", :href => "/admin/shelters/#{@shelter_2.id}")
    expect(page).to have_link("Alexandria for Squirrels", :href => "/admin/shelters/#{@shelter_3.id}")
    expect(page).to have_link("Shangri La for Turtles", :href => "/admin/shelters/#{@shelter_4.id}")
  end

  it "link to admin shelter show page is functional" do
    visit "admin/shelters"

    click_link "Taj Mahal for Dogs"
    expect(page).to have_current_path("/admin/shelters/#{@shelter_1.id}")

    visit "admin/shelters"

    click_link "Alexandria for Squirrels"
    expect(page).to have_current_path("/admin/shelters/#{@shelter_3.id}")
  end
end
