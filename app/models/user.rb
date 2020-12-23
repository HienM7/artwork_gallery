class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :username, presence: true,
						 uniqueness: true
	validates :password, presence: true,
						 length: {minimum: 5},
						 confirmation: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :credit_card,	numericality: true

	has_many :favorites
  has_many :fav_artworks, class_name: 'FavArtwork', through: :favorites,  :source => :artwork
end
