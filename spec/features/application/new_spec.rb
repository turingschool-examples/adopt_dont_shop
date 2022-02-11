require 'rails_helper'

RSpec.describe 'Application #new view' do 
    it 'has a form that allows the user to create a new application' do 
        visit '/application/new'
        
    end 
end 