class StatisticsController < ApplicationController
  def index
    @total_users = User.count
    @total_hoppers = Hopper.count
    @total_tasks = Task.count
    @total_users_day = User.last_seen(1.day.ago).count
    @total_users_week = User.last_seen(1.week.ago).count
    @total_users_month = User.last_seen(30.day.ago).count
  end
end
