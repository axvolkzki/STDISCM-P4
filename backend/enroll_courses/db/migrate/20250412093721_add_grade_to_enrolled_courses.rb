class AddGradeToEnrolledCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :enrolled_courses, :grade, :string
  end
end
