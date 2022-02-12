class Application <ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :post_code, presence: true
  validates :good_owner, presence: true

  attribute :status, :string, default: "In progress"

  has_many :application_pets
  has_many :pets, through: :application_pets
end
