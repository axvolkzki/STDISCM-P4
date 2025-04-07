class GradesController < ApplicationController
  before_action :authorized
  
  def index
    @enrolled_courses = EnrolledCourse
      .joins('INNER JOIN "courses" ON "courses".id = "enrolled_courses".courses_id')
      .joins('INNER JOIN "users" ON "users".id = "enrolled_courses".users_id')
      .select("enrolled_courses.*, users.*, courses.*")
      .order("enrolled_courses.id DESC")

    render json: @enrolled_courses
  end

  def upload
    course = EnrolledCourse.find_by(id: params["id"])
    course.grade = params["grade"]
    course.save

    render json: {id: params["id"], grade: params["grade"], success: true}
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
      @user = User.first
      # render json: { message: 'Please log in' }, status: :unauthorized    
    end
  end
end
