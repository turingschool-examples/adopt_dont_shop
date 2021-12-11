require 'rails_helper'

RSpec.describe "the application new page" do
  it "displays a form with relevant fields" do
    visit "/pets"
    click_link('Start an Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip')
  end

  it "fills in form and creates application" do
    visit "/pets"
    click_link('Start an Application')
    fill_in "Name", with: "Chris Hewitt"
    fill_in "Street address", with: "19072"
    fill_in "City", with: "Exeter"
    fill_in "State", with: "CA"
    fill_in "Zip", with: "93221"
    click_button("Submit")
    expect(Application.all.count).to eq(1)
    expect(page).to have_current_path("/applications/#{Application.last.id}")
    expect(page).to have_content("Chris Hewitt")
    expect(page).to have_content("19072")
    expect(page).to have_content("Exeter")
    expect(page).to have_content("CA")
    expect(page).to have_content("93221")
    expect(page).to have_content("I like turtles")
  end

  it "returns error for unfilled form" do
    #filling in form w/out name
    visit "/pets"
    click_link('Start an Application')
    fill_in "Street address", with: "19072"
    fill_in "City", with: "Exeter"
    fill_in "State", with: "CA"
    fill_in "Zip", with: "93221"
    click_button("Submit")
    expect(page).to have_content("Name can't be blank")
    expect(current_path).to eq("/applications/new")
    save_and_open_page
    expect(Application.all.count).to eq(0)
  end

end