class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  # Bootstrap flash types
  add_flash_types :success, :danger, :warning, :info
end
