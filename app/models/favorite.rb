class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :artwork

  def self.fav_count(artw_id)
    Favorite.where(artwork_id: artw_id).count
  end
end
