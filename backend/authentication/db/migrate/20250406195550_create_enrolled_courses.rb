class CreateEnrolledCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :enrolled_courses do |t|
      t.string :course_code
      t.integer :user_id
      t.decimal :grade

      t.timestamps
    end
  end
end
