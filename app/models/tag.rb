class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :artworks, through: :taggings
end
