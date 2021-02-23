class Artwork < ApplicationRecord
  belongs_to :category

  belongs_to :user
  # has_and_belongs_to_many: :users

  has_many :favorites, dependent: :destroy
  has_many :fav_users, through: :favorites, source: :user

  has_one_attached :image

  attr_accessor :tagnames

  include Taggable

  def self.search(keyword)
    artws = Artwork.artw_with_fav_count

    if keyword
      @artworks = artws.where(
        "lower(name) LIKE ?", "%#{keyword.downcase}%")
    else
      @artworks = artws.all
    end
  end

  def self.artw_with_fav_count
    fav_count_query =
      Favorite
      .select('COUNT(*)')
      .where('artwork_id = artworks.id')
      .to_sql

    Artwork.select("*", "(#{fav_count_query}) AS fav_count")  # pagination ?
  end

  def self.artw_with_author
    Artwork.includes(:user)
  end
end
