class GradesController < ApplicationController
  before_action :authorized

  def index
    # debug
    @enrolled_courses = EnrolledCourse
      .joins('INNER JOIN "courses" ON "courses".id = "enrolled_courses".courses_id')
      .select("courses.*, enrolled_courses.*")
      .where(users_id: @user.id)
    render json: @enrolled_courses
  end

  def decoded_token
    token = request.headers['Authorization']&.split(' ')&.last
    return unless token
    
    JwtService.decode(token) # Reuse your JWT service
  rescue JWT::DecodeError
    nil
  end

  def current_user 
    if decoded_token
      
        user_id = decoded_token['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def authorized
    unless !!current_user
      # @user = User.first
      render json: { message: 'Please log in' }, status: :unauthorized    
    end
  end
end
