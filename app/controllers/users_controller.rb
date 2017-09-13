class UsersController < ApplicationController
  def close_greeting
    current_user.show_greeting = false
    current_user.save!

    redirect_back fallback_location: root_path
  end
end
