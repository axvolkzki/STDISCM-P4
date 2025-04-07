class GradesController < ApplicationController
  def index
    # debug
    @user = User.find(12100001)

    @enrolled_courses = EnrolledCourse.where(users_id: @user.id)
    render json: @enrolled_courses
  end
end
