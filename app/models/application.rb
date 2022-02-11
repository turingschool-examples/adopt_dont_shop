class Application < ApplicationRecord
    has_many :pets
    validates :name, presence: true 
    validates :address, presence: true 
    validates :description, presence: true 
    validates :status, presence: true 
end