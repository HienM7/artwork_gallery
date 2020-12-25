class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 100 }
  has_many :artworks
end
