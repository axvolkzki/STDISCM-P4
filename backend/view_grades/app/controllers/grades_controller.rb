class GradesController < ApplicationController
  def index
    @enrolled_courses = EnrolledCourse.all
  end
end
