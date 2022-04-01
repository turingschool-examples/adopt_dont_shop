class Application < ApplicationRecord
  belongs_to :applicant

  validates_presence_of :pets
  validates_presence_of :status
end
