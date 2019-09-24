class UsersController < ApplicationController

  def show
    redirect_to new_user_session_path and return if !user_signed_in?
    @user = User.find(params[:id])
    @leave_application_requests = []
    @leave_application_requests = @user.leave_application_requests.where(active: 1) if @user.leave_application_requests.present? 
    
    if @user.role == "reporting_head" 
      @leave_application_requests  = LeaveApplicationRequest.where(active: 1)
    end
  end

end
