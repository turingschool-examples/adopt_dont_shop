class Application < ApplicationRecord
  validates_presence_of :name, :street, :city, :state, :zip
end
