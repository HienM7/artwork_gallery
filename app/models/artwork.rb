class Artwork < ApplicationRecord
  def self.search(keyword)
    if keyword
      @artworks = Artwork.where(
        "lower(name) LIKE ?", "%#{keyword.downcase}%"
      )
    else
      @artworks = Artwork.all
    end
  end
end
