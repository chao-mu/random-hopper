class TasksController < ApplicationController
  include HopperSetter

  before_action :set_task, only: [:destroy]

  def create
    @task = Task.new(task_params)
    @hopper.tasks << @task

    # TODO: handle fail
    @hopper.save
  end

  def unpin
    current_user.pinned_task = nil
    current_user.save

    respond_to do |format|
      format.js {render "shared/refresh_greeting"}
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    if current_user.pinned_task.id == @task.id
      current_user.pinned_task = nil
      current_user.save
    end
    @task.destroy

    redirect_back fallback_location: root_path
  end

  # POST /tasks


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
