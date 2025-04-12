class AddDetailsToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :class_number, :integer
    add_column :courses, :faculty_id, :integer  # This refers to a professor in `users`
    add_column :courses, :days, :string, limit: 2
    add_column :courses, :time, :string  # e.g. "12:45 - 14:15"
    add_column :courses, :room, :string
    add_column :courses, :remarks, :string, limit: 50
  end
end
