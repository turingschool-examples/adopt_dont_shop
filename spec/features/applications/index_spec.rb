require 'rails_helper'

RSpec.describe 'the applications index page' do
  before :each do
    @app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "I'm ready to love again" )
    @app_2 = Application.create!(name: "Benjamin Blue", street_address: "545 Boston Street", city: "Houston", state: "New York", zip_code: 02115, description: "I'm also ready")
  end

  it "shows all applications and all their attributes" do
    visit "/applications"

    expect(page).to have_content(@app_1.id)
    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.created_at)
  end

  it "links to show page" do
    visit "/applications"
    
    click_on("#{@app_1.name}}")

    expect(current_path).to eq("/applications/#{@app_1.id}")
  end

  it "links to edit page" do
    visit "/applications"

    within first(".row") do
      click_on("Update")
    end

    expect(current_path).to eq("/applications/edit")
  end
end