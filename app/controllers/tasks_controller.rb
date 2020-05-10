class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:show, :edit, :update]}

  PER = 10

  def index

    if params[:sort_expired] 
      @tasks = current_user.tasks.order(end_date: :asc).page(params[:page]).per(PER)
    elsif params[:sort_priority] 
      @tasks = current_user.tasks.order(priority: :asc).page(params[:page]).per(PER)
    else
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(PER)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = current_user.tasks.search_title(params[:title]).search_status(params[:status]).page(params[:page]).per(PER)
      elsif params[:title].present?
        @tasks = current_user.tasks.search_title(params[:title]).page(params[:page]).per(PER)
      elsif params[:status].present?
        @tasks = current_user.tasks.search_status(params[:status]).page(params[:page]).per(PER)
      end
    end

  end  

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを作成しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :end_date, :status, :priority)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end

  def ensure_correct_user
    if current_user.id != @task.user.id
      flash[:notice] = "権限がありません"
      redirect_to tasks_path
    end
  end
end
