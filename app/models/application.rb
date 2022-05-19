class Application < ApplicationRecord
  validates_presence_of :name, :address, :status, :description
end
