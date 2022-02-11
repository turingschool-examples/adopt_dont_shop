require 'rails_helper'

RSpec.describe 'Application show page' do
  before(:each) do
    @application = Application.create!(name: 'Mike',
                                      address: '123 Blake st., Denver, CO, 80211',
                                      description: 'I work from home',
                                      pet_names: 'Rufus',
                                      status:'In Progress')
  end

  it "should display application's attributes" do
    visit "applications/#{@application.id}"

    expect(page).to have_content("Mike")
    expect(page).to have_content("23 Blake st., Denver, CO, 80211")
    expect(page).to have_content("I work from home")
    expect(page).to have_content("Rufus")
    expect(page).to have_content("In Progress")
  end
end
