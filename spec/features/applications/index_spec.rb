require 'rails_helper'

RSpec.describe 'application index page' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @sammy = Pet.create!(adoptable: true, age: 1, breed: 'diluted calico', name: 'Sammy', shelter_id: @shelter.id)
    @smokie = Pet.create!(adoptable: true, age: 3, breed: 'tuxido', name: 'Smokie', shelter_id: @shelter.id)
    @application = Application.create!(name: 'Haewon Jeon',
                                      full_address: '305 Havard Dr., Fort Collins, CO 80212',
                                      description: "Because we are awesome",
                                      app_status: "pending")
    @application.pets << @sammy
    @application.pets << @smokie
  end

  it 'has a link to start an application' do
    visit "/applications"

    expect(page).to have_content("Start New Application")

    click_on "Start New Application"
    expect(current_path).to eq('/applications/new')
  end
end
