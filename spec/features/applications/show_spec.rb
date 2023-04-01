require 'rails_helper'

RSpec.describe "/applications/:id" do
  before do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
    @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
    @pet_2 = @shelter_1.pets.create!(name: "Bento", age: 23, breed: "dog")
    @pet_3 = @shelter_1.pets.create!(name: "Quiggle", age: 555,)
    @pet_4 = @shelter_1.pets.create!(name: "Simpleton", age: 80,)
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
  it "shows application info" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Bob's Application")
    expect(page).to have_content("123 Home St Denver, CO 80238")
    expect(page).to have_content("I love animals")
    expect(page).to have_link("#{@pet_1.name}", :href => "/pets/#{@pet_1.id}")
    expect(page).to have_link("#{@pet_3.name}", :href => "/pets/#{@pet_3.id}")
    expect(page).to have_link("#{@pet_5.name}", :href => "/pets/#{@pet_5.id}")
    expect(page).to have_content("In Progress")


    visit "/applications/#{@application_2.id}"

    expect(page).to have_content("Nebula's Application")
    expect(page).to have_content("45 Hippy Avenue Portland, OR 40009")
    expect(page).to have_content("Animals deserve to be freed into the woods")
    expect(page).to have_link("#{@pet_2.name}", :href => "/pets/#{@pet_2.id}")
    expect(page).to have_link("#{@pet_4.name}", :href => "/pets/#{@pet_4.id}")
    expect(page).to have_content("Pending")


    visit "/applications/#{@application_3.id}"

    expect(page).to have_content("Angry Tim's Application")
    expect(page).to have_content("94 Gun Street Dallas, TX 60888")
    expect(page).to have_content("Don't question me or my motives")
    expect(page).to have_link("#{@pet_4.name}", :href => "/pets/#{@pet_4.id}")
    expect(page).to have_link("#{@pet_5.name}", :href => "/pets/#{@pet_5.id}")
    expect(page).to have_content("Approved")
  end

  it "redirects when clicking on links" do
    visit "/applications/#{@application_2.id}"
    click_link "#{@pet_2.name}"
    expect(page).to have_current_path("/pets/#{@pet_2.id}")
    
    visit "/applications/#{@application_1.id}"
    click_link "#{@pet_3.name}"
    expect(page).to have_current_path("/pets/#{@pet_3.id}")
  end

  it "renders Add Pet section only if application is in progress" do
    visit "/applications/#{@application_1.id}"
 
    expect(page).to have_content("Add a pet to this application")
    expect(page).to have_field("pet_name")

    visit "/applications/#{@application_2.id}"

    expect(page).to have_no_content("Add a pet to this application")
    expect(page).to_not have_field("pet_name")

    visit "/applications/#{@application_3.id}"

    expect(page).to have_no_content("Add a pet to this application")
    expect(page).to_not have_field("pet_name")
  end

  it "searches for pets by name and displays them" do
    @pet_6 = @shelter_1.pets.create!(name: "Bento", age: 900, breed: "cat")
    visit "/applications/#{@application_1.id}"
    expect(page).to have_no_content("Bento")
  
    fill_in("pet_name", with: "Bento")
    click_button("Search")

    expect(page).to have_content("Name: Bento Breed: dog Age: 23")
    expect(page).to have_content("Name: Bento Breed: cat Age: 900")
  end

  it "has buttons next to searched_for pets" do
    visit "/applications/#{@application_1.id}"
    fill_in("pet_name", with: "Bento")
    click_button("Search")

    expect(page.all(:button, "Adopt this pet").count).to eq(1)

    @pet_6 = @shelter_1.pets.create!(name: "Bento", age: 900, breed: "cat")

    fill_in("pet_name", with: "Bento")
    click_button("Search")
  
    expect(page.all(:button, "Adopt this pet").count).to eq(2)
  end

  it "button adds pet to wishlist" do
    @pet_6 = @shelter_1.pets.create!(name: "Bento", age: 900, breed: "cat")
    visit "/applications/#{@application_1.id}"
    fill_in("pet_name", with: "Bento")
    click_button("Search")
    click_button("Adopt this pet", id: "Adopt #{@pet_6.id}")

    expect(page).to have_link("#{@pet_6.name}")
  end
end
