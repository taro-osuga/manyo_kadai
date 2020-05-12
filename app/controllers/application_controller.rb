class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper

    def authenticate_user 
      if session[:user_id] == nil 
        flash[:notice] = "ログインが必要です" 
        redirect_to root_path
      end
    end

    def user_logged_in
      if logged_in?
        flash[:notice] = "すでにログインしています"
        redirect_to user_path(current_user.id)
      end
    end

end
