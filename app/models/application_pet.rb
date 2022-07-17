class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: ['In Progress', 'Pending', 'Accepted', 'Rejected']
end
