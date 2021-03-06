class HoppersController < ApplicationController
  include HopperSetter

  def index
    @hoppers = current_user.hoppers
    @pinned = current_user.pinned_hopper
  end

  def export
    send_data @hopper.to_csv, filename: "#{@hopper.title}-#{Date.today.to_formatted_s(:db)}.csv"
  end

  def pin
    current_user.pinned_hopper = @hopper

    if @hopper.pinned_task.nil? && !@hopper.tasks.empty?
      @hopper.pinned_task = @hopper.tasks.sample
      @hopper.save!
    end

    current_user.show_greeting = false
    current_user.save!

    redirect_back fallback_location: root_path
  end

  def unpin
    @hopper.unpin
    redirect_back fallback_location: root_path
  end

  def start
    if @hopper.tasks.empty?
      redirect_back fallback_location: root_path, alert: 'Hopper empty!'
      return
    end

    @hopper.pinned_task = @hopper.tasks.sample
    @hopper.save!

    redirect_back fallback_location: root_path
  end

  def do_other
    tasks = @hopper.tasks_not_pinned
    if tasks.empty? && !@hopper.pinned_task.nil?
      @hopper.pinned_task.unpin
      redirect_back fallback_location: root_path, alert: 'No other tasks!'
      return
    end

    @hopper.pinned_task = tasks.sample
    @hopper.save!

    redirect_back fallback_location: root_path
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
