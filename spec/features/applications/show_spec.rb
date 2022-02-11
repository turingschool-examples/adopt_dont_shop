require 'rails_helper'

RSpec.describe 'Application show page' do
  before(:each) do
    @application = Application.create!(name: 'Mike',
                                      address: '123 blake st., Denver, CO, 80211',
                                      description: 'I work from home',
                                      pet_names: 'Rufus',
                                      status:'In Progress')
  end

  it "should display application's attributes" do
    visit "application/show"
  end
end
