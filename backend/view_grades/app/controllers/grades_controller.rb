class GradesController < ApplicationController
  before_action :authorized

  def index
    # debug
    @enrolled_courses = EnrolledCourse.where(users_id: @user.id)
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
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def authorized
    unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
