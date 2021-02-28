class AdminController < ApplicationController
  before_action :authorized?

  protected
    def authorized?
      unless current_user && current_user.is_admin
        flash[:error] = "You are not authorized to view that page."
        redirect_to home_path
      end
    end
end
