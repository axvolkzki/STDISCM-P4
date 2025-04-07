class AddUserAndCourseToEnrolledCourse < ActiveRecord::Migration[8.0]
  def change
    add_reference :enrolled_courses, :users, null: true, foreign_key: true
    add_reference :enrolled_courses, :courses, null: true, foreign_key: true
  end
end
