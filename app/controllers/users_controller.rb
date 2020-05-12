class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:index,  :edit, :update]}
    before_action :user_logged_in, {only: [:new]}
    before_action :ensure_correct_user, {only: [:show, :edit, :update]}

    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_path, notice: "ユーザー情報を修正しました"
        else
            render :edit
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
    end

    def ensure_correct_user
        if current_user.id != params[:id].to_i
          flash[:notice] = "権限がありません"
          redirect_to tasks_path
        end
    end
    
end
