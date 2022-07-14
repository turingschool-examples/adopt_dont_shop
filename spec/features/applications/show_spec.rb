require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'lists applications attributes' do
    app = Application.create!(name: 'Brigitte Bardot', address: '123 Main Street, Denver, CO, 80111',
                              description: 'I love animals!', status: 0)
    app2 = Application.create!(name: 'Calliope Carson', address: '124 Central Avenue, Denver, CO, 80111',
                               description: 'I really love animals!', status: 1)

    visit "/applications/#{app.id}"

    expect(page).to have_content('Brigitte Bardot')
    expect(page).to have_content('123 Main Street, Denver, CO, 80111')
    expect(page).to have_content('I love animals!')
    expect(page).to have_content('In Progress')
    expect(page).to_not have_content('Calliope Carson')
    expect(page).to_not have_content('124 Central Avenue, Denver, CO, 80111')
    expect(page).to_not have_content('Pending')
  end
end
