class CreateEnrolledCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :enrolled_courses do |t|
      t.decimal :grade

      t.timestamps
    end
  end
end
