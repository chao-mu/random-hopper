class WelcomeController < ApplicationController
  # Skip authentication
  skip_before_action :authenticate_user!

  layout 'welcome'

  def index
  end
end
