require 'rails_helper'

RSpec.describe "#show" do
  xdescribe 'user story 1' do
    describe 'When user visits application show page' do
      it 'displays the name of the applicant' do

        visit "/application/#{application_id}"

        expect(page).to have_content "#{application.applicant_name}"
      end
    end
  end
end