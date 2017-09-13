class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  before_action :set_last_seen_at, if: proc { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 15.minutes.ago) }

  add_flash_types :success

  private
  def set_last_seen_at
      current_user.update_column(:last_seen_at, Time.now)
  end
end
