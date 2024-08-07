class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :manager_user, only: [:destroy]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @activities = @user.activities.paginate(page: params[:page])
    @feed_items = @user.feed.paginate(page: params[:page])
    @grouped_activities = @activities.group_by { |activity| week_range(activity.run_at) }
    @week_averages = @grouped_activities.transform_values do |activities|
      total_distance = activities.sum(&:distance)
      total_time = activities.sum(&:hours) * 60 + activities.sum(&:minutes) + activities.sum(&:seconds) / 60.0
      average_distance = total_distance / activities.size.to_f
      average_time = total_time / activities.size.to_f
      average_pace = average_time / average_distance
      {
        average_distance: average_distance,
        average_pace: average_pace
      }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the JogTrack!"
      redirect_back_or @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) || current_user.manager? || current_user.admin?
    end

    def manager_user
      redirect_to(root_url) unless current_user.manager? || current_user.admin?
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin? || current_user.manager?
    end

    def correct_user?
      current_user == @user
    end

    def week_range(date)
      start_of_week = date.beginning_of_week
      end_of_week = date.end_of_week
      { start: start_of_week, end: end_of_week }
    end
end
