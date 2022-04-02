require 'rails_helper'

RSpec.describe 'Applications Index' do
  it "lists all applications" do
    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty')

    visit ('/applications')
    expect(page).to have_current_path('/applications')

    expect(page).to have_content(@application_1.name)

  end
end
