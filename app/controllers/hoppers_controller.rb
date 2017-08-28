class HoppersController < ApplicationController
  def pop
    hopper = Hopper.where(user: current_user, id: params[:hopper_id]).first
    if hopper.nil?
      redirect_back fallback_location: root_path, danger: 'Hopper not found.'
      return
    end

    things = hopper.things.where.not(id: current_user.pinned_thing_id)
    if things.empty?
      redirect_back fallback_location: root_path, warning: 'Hopper empty!'
      return
    end

    current_user.pinned_thing = things.sample
    current_user.save

    redirect_back fallback_location: root_path, success: 'Hopper popped!'
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

  private
    def hopper_params
      params.require(:hopper).permit(:title)
    end
end
