class HomeController < ApplicationController
  def index
    @hoppers = current_user.hoppers
    @pinned = current_user.pinned_thing
  end
end
