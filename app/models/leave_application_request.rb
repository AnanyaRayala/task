class LeaveApplicationRequest < ApplicationRecord
  belongs_to :user
  
  enum leave_status: [:applied, :approved, :rejected]
end
