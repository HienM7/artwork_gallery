class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		#if session[:user] != 'user'
			#redirect_to :action => 'login'
		#end
		@user = current_user
	end

	def xulylogin
		@user = User.find_by(username:user_params[:username])
		if @user
			if @user.password == user_params[:password]
				session[:user] = 'user'
				redirect_to :action => 'show', :id => @user.id
			else
				flash[:login_errors] = ['Mat khau sai, hay nhap lai!']
				render 'login'
			end
		else
			flash[:login_errors] = ['Tai khoan khong ton tai!']
			render 'login'
		end
	end

	def login
		session[:user] = ''
	end

	def new
		@user = User.new
	end

	def create
		user = params.require(:user).permit(:username, :password, :email, :credit_card, :password_confirmation)
		is_admin = "is_admin"
		is_banned = "is_banned"
		point = "point"
		user[is_admin.to_sym] = false
		user[is_banned.to_sym] = false
		user[point.to_sym] = 0
		@user = User.create(user)
		if @user.save
			redirect_to :action => 'login'
		else render 'new'
		end
	end
	
	private def user_params
		params.require(:user).permit(:username, :password)
	end
end
