class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    if params[:sort_expired] 
      @tasks = Task.all.order(end_date: :asc)
    else
      @tasks = Task.all.order(created_at: :desc)
    end

    if params[:search].present?
      if params[:title].present? && params[:status].present?
        @tasks = Task.search_title(params[:title]).search_status(params[:status])
      elsif params[:title].present?
        @tasks = Task.search_title(params[:title])
      elsif params[:status].present?
        @tasks = Task.search_status(params[:status])
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
    params.require(:task).permit(:title, :content, :end_date, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end

end
