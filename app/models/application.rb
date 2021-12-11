class Application < ApplicationRecord
    validates :name, presence: true
    validates :address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true
    validates :reason, presence: true
    has_many :pet_applications
    has_many :pets, through: :pet_applications
end
