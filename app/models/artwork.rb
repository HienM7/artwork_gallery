class Artwork < ApplicationRecord
  # has_and_belongs_to_many: :users
  has_many :favorites
  has_many :fav_users, class_name: 'FavUser', through: :favorites,  :source => :user

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
