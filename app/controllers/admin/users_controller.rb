class Admin::UsersController < ApplicationController
    before_action :admin_user
    before_action :set_user, only: [:show, :edit, :destroy]

    PER = 10

    def new
      @user = User.new
    end
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_user_path(@user.id)
      else
        render :new
      end
    end

    def show
      @user = User.find(params[:id])
        if params[:sort_expired] 
          @tasks = @user.tasks.order(end_date: :asc).page(params[:page]).per(PER)
        elsif params[:sort_priority] 
          @tasks = @user.tasks.order(priority: :asc).page(params[:page]).per(PER)
        else
          @tasks = @user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
        end
        if params[:search].present?
          if params[:title].present? && params[:status].present? && params[:label_id].present?
            @tasks = @user.tasks.search_title(params[:title]).search_status(params[:status]).page(params[:page]).per(PER)
          elsif params[:title].present?
            @tasks = @user.tasks.search_title(params[:title]).page(params[:page]).per(PER)
          elsif params[:status].present?
            @tasks = @user.tasks.search_status(params[:status]).page(params[:page]).per(PER)
          elsif params[:label_ids].present?
            @label_id = params[:label_ids]
            @task_ids = TaskLabel.where(label_id: @label_id).pluck(:task_id)
            @tasks = @user.tasks.search_labels(@task_ids).page(params[:page]).per(PER)
          end
        end
    end

    def index
      @users = User.all.order("created_at ASC")
    end
  
    def edit
      @user = User.find(params[:id])
    end
    
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
          redirect_to admin_users_path, notice: "ユーザー情報を修正しました"
      else
          render :edit
      end
    end
  
    def destroy
      @user.destroy
      redirect_to admin_users_path, notice:"ユーザー情報を削除しました！"
    end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,:image_name,:admin)
    end 

    def set_user
      @user = User.find(params[:id])
    end 

    def admin_user
      if current_user.admin?
          flash[:notice] = "あなたは管理者です"
      else
      redirect_to(tasks_path) 
      flash[:notice] = "あなたは管理者ではありません"
      end
    end 

  end
