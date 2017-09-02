class HoppersController < ApplicationController
  include HopperSetter

  def index
    @hoppers = current_user.hoppers
    @pinned = current_user.pinned_task
  end

  def pop
    if @hopper.nil?
      redirect_back fallback_location: root_path, danger: 'Hopper not found.'
      return
    end

    tasks = @hopper.tasks.where.not(id: current_user.pinned_task_id)
    if tasks.empty?
      redirect_back fallback_location: root_path, warning: 'Hopper empty!'
      return
    end

    current_user.pinned_task = tasks.sample
    current_user.save

    respond_to do |format|
      format.js { render "shared/refresh_greeting" }
      format.html { redirect_back fallback_location: root_path }
    end
  end

  def destroy
    @hopper.destroy
    redirect_back fallback_location: root_path
  end

  # POST /hoppers
  def create
    @hopper = Hopper.new(hopper_params)
    @hopper.user = current_user

    if @hopper.save
      redirect_back fallback_location: root_path, success: 'Hopper was successfully created.'
    else
      redirect_back fallback_location: root_path
    end
  end

  protected

  def hopper_id_key
    :id
  end

  private
    def hopper_params
      params.require(:hopper).permit(:title)
    end
end
