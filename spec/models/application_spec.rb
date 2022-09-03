require 'rails_helper'

RSpec.describe Application, type: :model do
    describe "relationships" do
        
        it { should have_many :application_pets }
        it { should have_many(:pets).through(:application_pets) }

        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:street_address) }
        it { should validate_presence_of(:state) }
        it { should validate_presence_of(:zip_code) }

        before(:each) do
            @shelter1 = Shelter.create!(foster_program: "true", name:"Furry Friends", city: "Denver", rank:"3")
            @cookie = @shelter1.pets.create!(adoptable: "true", name: "Cookie", breed:"chihuahua", age:"5")
            @spot = @shelter1.pets.create!(adoptable: "true", name: "Spot", breed:"dalmation", age:"2")
            @dash = @shelter1.pets.create!(adoptable: "false", name: "Dash", breed:"golden retriever", age:"13")

            @john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", status: 'Pending')
            @john_doe_app.pets << [@cookie, @spot]
        end

        describe 'instance methods' do
            describe '.app_pets_and_pets' do
                it 'can return the app pet object with the pets information included' do
                    expect(@john_doe_app.app_pets_and_pets[0].name).to eq("Cookie")
                    expect(@john_doe_app.app_pets_and_pets[0]).to respond_to(:status)
                    expect(@john_doe_app.app_pets_and_pets[1].name).to eq("Spot")
                    expect(@john_doe_app.app_pets_and_pets[1]).to respond_to(:status)
                end
            end
        end
    end
end