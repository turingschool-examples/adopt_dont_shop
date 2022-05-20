require 'rails_helper'

RSpec.describe 'Application Show Page', type: :feature do 
    describe 'visuals' do 
        xit 'can see attributes of the applicant' do 
            applicant1 = (name: '')
            expect(page).to have_content(applicant.name)
        end
    end
end