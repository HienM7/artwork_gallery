class Artwork < ApplicationRecord
  # has_and_belongs_to_many: :users
  has_one_attached :image
  has_many :favorites
  has_one :category
  has_many :fav_users, class_name: 'FavUser', through: :favorites,  :source => :user
  belongs_to :user
  
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
