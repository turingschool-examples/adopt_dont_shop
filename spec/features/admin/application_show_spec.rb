require 'rails_helper'

RSpec.describe "/admin/applications/:id" do
  before do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
    @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
    @pet_2 = @shelter_1.pets.create!(name: "Bento", age: 23, breed: "dog")
    @pet_3 = @shelter_1.pets.create!(name: "Quiggle", age: 555,)
    @pet_4 = @shelter_1.pets.create!(name: "Simpleton", age: 80,)
    @pet_5 = @shelter_1.pets.create!(name: "Dragon", age: 400,)
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

  it "has an accept button next to each pet" do
    visit "/admin/applications/#{@application_1.id}"

    expect(page.all(:link, "Approve this Pet!").count).to eq(3)

    visit "/admin/applications/#{@application_3.id}"

    expect(page.all(:link, "Approve this Pet!").count).to eq(2)    
  end

  it "removes link and shows that pet has been approved" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page.all(:link, "Approve this Pet!").count).to eq(3)
    expect(page).to have_no_content("The application for this pet has been approved.")
    click_link("Approve #{@pet_1.id}")

    expect(page.all(:link, "Approve this Pet!").count).to eq(2)
    expect(page).to have_content("The application for this pet has been approved.")
  end

  it "reject button exists" do 
    visit "/admin/applications/#{@application_1.id}"

    expect(page.all(:link, "Reject this Pet").count).to eq(3)

    visit "/admin/applications/#{@application_3.id}"

    expect(page.all(:link, "Reject this Pet").count).to eq(2)
  end

  it "reject button works" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page.all(:link, "Reject this Pet").count).to eq(3)
    expect(page).to have_no_content("The application for this pet has been denied.")
    click_link("Reject #{@pet_1.id}")
    
    expect(page.all(:link, "Reject this Pet").count).to eq(2)
    expect(page).to have_content("The application for this pet has been denied.")
  end

  # describe 'All Pets accepted on Application' do
  #   it 'Once all pets are approved page redirects to show page and shows Approved status' do
  #     visit "/admin/applications/#{@application_1.id}"

  #     click_link("Approve #{@pet_1.id}")
  #     click_link("Approve #{@pet_3.id}")
  #     click_link("Approve #{@pet_5.id}")

  #     expect(page.all(:link, "Reject this Pet").count).to eq(0)
  #     expect(page.all(:link, "Approve this Pet!").count).to eq(0)
  #     expect(current_path).to eq("/admin/applications/#{@application_id.id}")
  #     expect(page).to have_content("Application Approved")
  #   end
  # end

  it "doesn't affect pets on other applications" do
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_no_content("The application for this pet has been denied.")
    click_link("Reject #{@pet_5.id}")
    expect(page).to have_content("The application for this pet has been denied.")
    
    visit "/admin/applications/#{@application_2.id}"
    expect(page).to have_no_content("The application for this pet has been approved.")
    click_link("Approve #{@pet_4.id}")
    expect(page).to have_content("The application for this pet has been approved.")
    
    visit "/admin/applications/#{@application_3.id}"
    expect(page).to have_no_content("The application for this pet has been approved.")
    expect(page).to have_no_content("The application for this pet has been denied.")
    
    visit "/admin/applications/#{@application_1.id}"
    expect(page).to have_content("The application for this pet has been denied.")
    
    visit "/admin/applications/#{@application_2.id}"
    expect(page).to have_content("The application for this pet has been approved.")
  end
end