class RemoveFacultyIdFromCourses < ActiveRecord::Migration[8.0]
  def change
    remove_column :courses, :faculty_id, :integer
  end
end
