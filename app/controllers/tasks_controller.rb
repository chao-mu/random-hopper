class TasksController < ApplicationController
  include HopperSetter

  before_action :set_task, only: [:destroy]

  def create
    @task = Task.new(task_params)
    @hopper.tasks << @task
    @hopper.save!
  end

  def destroy
    if @task.hopper.pinned_task == @task
      @task.hopper.pinned_task = nil
      @task.hopper.save!
    end

    @task.destroy

    redirect_back fallback_location: root_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
      if @task.hopper.user != current_user
        redirect_back fallback_location: root_path, danger: 'Not authorized'
      end
    end


    def task_params
      params.require(:task).permit(:text)
    end
end
