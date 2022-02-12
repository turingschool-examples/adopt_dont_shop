class Application < ApplicationRecord

    validates :name, presence: true
    validates :street, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true

    attribute :description, :string, default: "TBFI later"
    attribute :status, :string, default: "In progress"

    has_many :pet_applications, dependent: :destroy
    has_many :pets, through: :pet_applications


end
