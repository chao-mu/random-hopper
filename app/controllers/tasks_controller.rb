class TasksController < ApplicationController
  include HopperSetter

  before_action :set_task, only: [:destroy, :finish]

  def create
    @task = Task.new(task_params)
    @hopper.tasks << @task
    @hopper.save!
  end

  def finish
    @task.destroy

    flash[:finished] = [
      "All hail the defeater of the task!",
      "Boom shakalaka!",
      "Awww yis",
      "Duck yeah!",
      "Dun dun dun, another one bites the dust!",
      "Another one gone, and another one gone...",
      "Ain't no sound but the sound of his feet",
      "LIKE A BOSS",
      "Winning!",
      "[insert cat picture here] (sic)",
      "Boom shakalaka!",
      "Whoop there it is!"
    ].sample

    redirect_back fallback_location: root_path
  end

  def destroy
    @task.destroy

    redirect_back fallback_location: root_path
  end

  private
    def set_task
      @task = Task.find(params.fetch(:task_id, params[:id]))
      if @task.hopper.user != current_user
        redirect_back fallback_location: root_path, danger: 'Not authorized'
      end
    end


    def task_params
      params.require(:task).permit(:text)
    end
end
