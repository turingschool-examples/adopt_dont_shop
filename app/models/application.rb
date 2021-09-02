class Application < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejectd']
end
