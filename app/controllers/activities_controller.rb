class ActivitiesController < ApplicationController
    before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    
    def new
        @activity = Activity.new
    end

    def create
        @activity = current_user.activities.build(activity_params)
        if @activity.save
            flash[:success] = "Activity created"
            redirect_to root_url
        else
            render 'new'
        end
    end

    def edit
        @activity = Activity.find_by(id: params[:id])
    end

    def update
        @activity = Activity.find_by(id: params[:id])
        if @activity.update(activity_params)
            flash[:success] = "Activity updated"
            redirect_to root_path
        else
            render 'edit'
        end
    end

    def destroy
        @activity.destroy
        flash[:success] = "Activity deleted"
        redirect_to request.referrer || root_url
    end

    private
        def activity_params
            params.require(:activity).permit(:distance, :hours, :minutes, :seconds, :title, :description, :run_at, :location)
        end
        
        def correct_user
            @activity = Activity.find_by(id: params[:id])
            redirect_to root_url unless @activity && (current_user.admin? || @activity.user == current_user)
        end
        
end
