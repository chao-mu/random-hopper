class WelcomeController < ApplicationController
  # Skip authentication
  skip_before_action :authenticate_user!

  def index
  end
end
