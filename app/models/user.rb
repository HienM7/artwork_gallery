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
	has_many :favorites
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
end
