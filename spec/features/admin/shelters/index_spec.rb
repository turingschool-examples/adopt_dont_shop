require 'rails_helper'

RSpec.describe 'The Admin Shelters Index' do 

    before :each do 
        @dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        @smart_friends_league = Shelter.create!(foster_program: true, name: "Smart Friends League", city: "Lakewood", rank: "2")
    end

    describe 'Shows all shelters in the system in reverse alphabetical order' do 
    visit '/admin/shelters/'
    expect(page).to have_content(@dumb_friends_league.name)
    expect(page).to have_content(@smart_friends_league.name)
    expect(@smart_friends_league).to appear_before(@dumb_friends_league)
    end 
end