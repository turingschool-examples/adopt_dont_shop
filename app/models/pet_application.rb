class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  #validate these
end
