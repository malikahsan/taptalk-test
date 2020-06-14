class V1::DailyActivitiesController < ApplicationController
  def index
    raise ActionController::BadRequest, "Year can't be empty" if activity_params[:year].blank? && activity_params[:quarter].present?
    raise ActionController::BadRequest, "Qarter value only 1-4" if activity_params[:quarter].present? && !(1..4).to_a.include?(activity_params[:quarter].to_i)
    @daily_activities = DailyActivity.activities_list(activity_params)
  end

  def create
    check_activity_date = DailyActivity.find_by(activity_at: activity_params[:activity_at])
    if check_activity_date.present?
      check_activity_date.update(activity_params)
      @activity = check_activity_date
    else
      @activity = DailyActivity.create!(activity_params)
    end
  end

  private
  def activity_params
    params[:daily_activity][:year] = params[:year] if params[:year].present?
    params[:daily_activity][:quarter] = params[:quarter] if params[:quarter].present?
    params.fetch(:daily_activity, {}).permit(:activity, :activity_at, :year, :quarter).merge(user_id: current_user.id)
  end
end
