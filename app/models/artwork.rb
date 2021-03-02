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

  def cldn_url(width=420, height=280)
    Cloudinary::Utils.cloudinary_url(
      self.image.key,
      width: width, height: height,
      sign_url: true,
      gravity: "center",
      crop: "thumb"
    )
  end

  def low_res_url
    Cloudinary::Utils.cloudinary_url(
      self.image.key,
      transformation: [
        {
          sign_url: true
        },
        {
          if: "width > 855 and height > 570",
            width: "855",
            quality: 90,
            crop: "scale"
        },
        {
          if: "else",
            quality: 85
        }
      ]
    )
  end
end
