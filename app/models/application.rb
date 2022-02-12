class Application < ApplicationRecord
  class Petapplication < ApplicationRecord

    validates :name, presence: true
    validates :street, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip, presence: true
    validates :description, presence: true
    validates :status, presence: true

    has_many :pet_petapplications, dependent: :destroy
    has_many :pets, through: :pet_petapplications

    def set_defaults
      self.description ||= "TBFI later"
      self.status ||= "In progress"
    end
  end

end
