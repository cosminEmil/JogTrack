class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @activity = current_user.activities.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def add_activity 
    @activity = current_user.activities.build if logged_in?
  end
end
