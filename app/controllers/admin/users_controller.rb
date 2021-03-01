class Admin::UsersController < AdminController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  skip_before_action :authorized?, only: [:show_profile, :show_my_profile]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params_create)

    if @user.save
      redirect_to admin_users_path, flash: { success: 'User was successfully created.' }
    else
      render action: 'new'
    end
  end

	def update
    if @user.update_attributes(user_params_update)
      redirect_to admin_users_path, flash: { success: 'User was successfully updated.' }
		else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, flash: { success: 'User was successfully deleted.' }
  end

  def show_my_profile
    if not current_user
      redirect_to new_user_session_path
    else
      @user = User.find(current_user.id)
      render 'profile', locals: { my_profile: true }
    end
  end

  def show_profile
    if current_user && current_user.id == params[:id].to_i
      redirect_to my_profile_path
    else
      @user = User.find(params[:id])
      render 'profile', locals: { my_profile: false }
    end
  end

	private

		def find_user
			@user = User.find params[:id]
		end

    def user_params_create
      params.require(:user).permit(:username, :password, :password_confirmation, :email, :point)
		end

		def user_params_update
			if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
				params[:user].delete(:password)
				params[:user].delete(:password_confirmation)
				params.require(:user).permit(:username, :email, :point)
			else
      	params.require(:user).permit(:username, :password, :password_confirmation, :email, :point)
			end
		end
end
