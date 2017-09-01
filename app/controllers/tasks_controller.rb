class TasksController < ApplicationController
  before_action :set_task, only: [:destroy]

  def unpin
    current_user.pinned_task = nil
    current_user.save

    redirect_back fallback_location: root_path
  end

  def destroy
    if current_user.pinned_task.id == @task.id
      current_user.pinned_task = nil
      current_user.save
    end
    @task.destroy

    redirect_back fallback_location: root_path, success: 'DESTROYED!!!!'
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.hopper.user != current_user
      redirect_back fallback_location: root_path, danger: 'Not authorized'
      return
    end

    if @task.save
      redirect_back fallback_location: root_path, success: 'task successfully added to hopper.'
    else
      redirect_back fallback_location: root_path
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
      if @task.hopper.user != current_user
        redirect_back fallback_location: root_path, danger: 'Not authorized'
      end
    end

    def task_params
      params.require(:task).permit(:hopper_id, :text)
    end
end
