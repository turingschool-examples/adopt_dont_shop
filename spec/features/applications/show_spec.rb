require 'rails_helper'

RSpec.describe "Applications Show" do
  before :each do
    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty', status: "In Progress")
  end

  it "shows an application" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Carol Crikey")
    expect(page).to have_content("2022 S Fake Street")
    expect(page).to have_content("Birmingham")
    expect(page).to have_content("AL")
    expect(page).to have_content("54738")
    expect(page).to have_content("In Progress")
    expect(page).to have_content("empty")
  end
end
