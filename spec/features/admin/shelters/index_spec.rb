require 'rails_helper'

RSpec.describe 'admin shelters index' do 
    describe 'SQL only story' do 
        before :each do 
            @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
            @shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
            @shelter_3 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 7)
        end
        it 'has raw SQL for admin shelters query for reverse alphabetical order' do 
            visit '/admin/shelters'
            save_and_open_page
             expect(@shelter_3.name).to appear_before(@shelter_2.name)
             expect(@shelter_2.name).to appear_before(@shelter_1.name)
        end
    end
end