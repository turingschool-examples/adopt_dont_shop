require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'instance methods' do
    it 'should default application_status to in progress' do
      application = Application.new
      application.save
      application.application_status.should == 'In Progress'
    end

    it 'can check for incomplete form text fields' do
      application = Application.new(name: 'Peter', city: ' ')
      application.save
      application.form_incomplete?.should == true
    end
  end
end
