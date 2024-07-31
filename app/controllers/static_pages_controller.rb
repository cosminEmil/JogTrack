class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @activity = current_user.activities.build

      if params[:start_date].present? && params[:end_date].present?
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        @feed_items = current_user.feed.where(run_at: start_date.beginning_of_day..end_date.end_of_day).paginate(page: params[:page])
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
    end
  end

  def add_activity 
    @activity = current_user.activities.build if logged_in?
  end
end
