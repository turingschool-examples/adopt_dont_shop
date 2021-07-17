class Application < ApplicationRecord
  has_many :pet_applications
  # has_many :playlists, through: :playlist_songs

end
