class SurveyPet < ApplicationRecord 
  belongs_to :pet 
  belongs_to :survey
end