module HopperSetter
  extend ActiveSupport::Concern

  included do
    before_action :set_hopper
  end

  protected

  def hopper_id_key
    :hopper_id
  end

  def set_hopper
    if params.has_key? hopper_id_key
      @hopper = Hopper.where(user: current_user, id: params[hopper_id_key]).first
      if @hopper.nil?
        redirect_back fallback_location: root_path, danger: 'Hopper not found.'
      end
    end
  end
end
