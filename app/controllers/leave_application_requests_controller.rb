class LeaveApplicationRequestsController < ApplicationController
  before_action :new_params, only: :new
  before_action :find_lr, only: [:edit, :destroy, :update]
  before_action :extra_params, only: [:update]

  def new
    @leave_application_request = LeaveApplicationRequest.new(user_id: params[:user_id])
    @leave_application_request.apply_date = Date.today
    @leave_application_request.from_date = Date.today
  end

  def create
    @leave_application_request = LeaveApplicationRequest.new(request_params)
    if @leave_application_request.save
      DtMailer.send_application_status(
        @leave_application_request.user.email, 
        "created",
         @leave_application_request.user_name
      ).deliver_now
      redirect_to user_path(@leave_application_request.user_id)
    else
      render json: { failed: 'ok', message: "Couldn't create successfully" }
    end
  end

  def edit
    @action  = params[:action_to_do]
    @leave_application_request.apply_date = Date.today
    @leave_application_request.from_date = Date.today
  end

  def update
    if @leave_application_request.update_attributes(request_params)
      @user = @leave_application_request.user
      if @leave_application_request.leave_status  == "approved"
        @user.leave_balance = @user.leave_balance.to_i - 1
        @user.save
      end 

      DtMailer.send_application_status(
        @user.email, 
        "edited",
         @leave_application_request.user_name
      ).deliver_now

      user_id = @leave_application_request.user_id

      if params[:leave_application_request][:leave_status].present? && 
         params[:leave_application_request][:user_id].present?
        user_id =  params[:leave_application_request][:user_id]
      end

      redirect_to user_path(user_id)
    else
      render json: { failed: 'ok', message: "Couldn't update successfully" }
    end
  end

  def destroy
    @leave_application_request.active = false
    if @leave_application_request.save
      DtMailer.send_application_status(
        @leave_application_request.user.email, 
        "cancelled",
         @leave_application_request.user_name
      ).deliver_now
      redirect_to user_path(@leave_application_request.user_id)
    else
      render json: { failed: 'ok', message: "Couldn't cancel request" }
    end
  end

  def request_params
    params.require(:leave_application_request).permit(
      :user_name, :apply_date, :from_date, :to_date, :reason, :reporting_head, :leave_status, :active, :user_id
    )
  end

  def new_params
    params.permit!
  end

  def extra_params
    params[:leave_application_request][:leave_status] = params[:leave_application_request][:leave_status].to_i
    params[:leave_application_request][:user_id] = params[:leave_application_request][:user_id].to_i
  end

  def find_lr
    @leave_application_request = LeaveApplicationRequest.find(params[:id])
  end

end
