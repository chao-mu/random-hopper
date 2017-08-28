class ThingsController < ApplicationController
  before_action :set_thing, only: [:destroy]
  
  def unpin
    current_user.pinned_thing = nil
    current_user.save

    redirect_back fallback_location: root_path
  end

  def destroy
    if current_user.pinned_thing.id == @thing.id
      current_user.pinned_thing = nil
      current_user.save
    end
    @thing.destroy

    redirect_back fallback_location: root_path, success: 'DESTROYED!!!!'
  end

  # POST /things
  def create
    @thing = Thing.new(thing_params)
    if @thing.hopper.user != current_user
      redirect_back fallback_location: root_path, danger: 'Not authorized'
      return
    end

    if @thing.save
      redirect_back fallback_location: root_path, success: 'Thing successfully added to hopper.'
    else
      redirect_back fallback_location: root_path
    end
  end

  private
    def set_thing
      @thing = Thing.find(params[:id])
      if @thing.hopper.user != current_user
        redirect_back fallback_location: root_path, danger: 'Not authorized'
      end
    end

    def thing_params
      params.require(:thing).permit(:hopper_id, :text)
    end
end
