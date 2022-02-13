require 'rails_helper'

describe 'application' do
  before(:each) do
    @shelter = Shelter.create!(foster_program: true,
                  name: "frankie's friendly felines",
                  city: "westminster",
                  rank: 10)
    @application = Application.create!(name: "Frank",
                  street: "123 blaine st",
                  city: "Sioux falls",
                  state: "SD",
                  zip: 80342,
                  description: "I'm a meat popsicle looking for a companion.",
                  status: "In progress")
    @bean = Pet.create!(
                  name: "Bean",
                  adoptable: true,
                  age: 1,
                  breed: "cat",
                  shelter_id: @shelter.id)
  end
  it 'displays a link to applicant info' do
    # binding.pry
    visit "/applications/#{@application.id}"
    #save_and_open_page
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
  end

  it "has 'add a pet' to the application form on the show page" do
    visit "/applications/#{@application.id}"
    #save_and_open_page
    expect(page).to have_content("Add a pet")
  end

  it "has a search form that populates when application is in progress" do
    visit "/applications/#{@application.id}"
    fill_in('pet_name', with: "#{@bean.name}")
    click_button("Search")
    expect(page).to have_content("Bean")
  end

  it "adds a pet to the application." do
    visit "/applications/#{@application.id}"
    fill_in('pet_name', with: "#{@bean.name}")
    click_button("Search")
    click_button("Adopt Bean")
    save_and_open_page
    expect(current_path).to eq("/applications/#{@app.id}")
  end
end
