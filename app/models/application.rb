class Application < ApplicationRecord
    has_many :applicants
    has_many :pets
end