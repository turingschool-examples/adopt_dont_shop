require 'rails_helper'

RSpec.describe 'application show' do

  it 'shows application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    # binding.pry
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
  end


end
