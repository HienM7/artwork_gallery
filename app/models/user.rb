class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	validates :username, presence: true,
						 uniqueness: true
	# validates :password,
	# 					 length: {minimum: 5},
	# 					 confirmation: true
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :credit_card,	numericality: true

	has_many :artworks
	has_many :favorites, dependent: :destroy
  has_many :fav_artworks, through: :favorites, source: :artwork

	def make_donation(artw, amount)
		transfer(artw.user, amount)
	end

	def make_purchase(artw)
		transfer(artw.user, artw.value)
	end

	def transfer(receiver, amount)
		if amount == 0
			true
		elsif self.point >= amount
			self.point -= amount
			receiver.point += amount

			self.save!
			receiver.save!

			true
		else
			false
		end
	end

	def recent_favorites(num: 5)
		fav_users_query = Favorite.joins(:user).select('users.id as fu_id, users.username as fu_name, favorites.artwork_id as fa_id, favorites.created_at as f_time').to_sql

		self.artworks
		.joins("INNER JOIN (#{fav_users_query}) AS fav_users ON artworks.id = fav_users.fa_id")
		.select('artworks.name as a_name, fav_users.fu_id as fu_id, fav_users.fu_name as fu_name, fav_users.fa_id as fa_id, fav_users.f_time as f_time')
		.order('f_time DESC')
		.limit(num)
	end
end
