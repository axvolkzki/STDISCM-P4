class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :code
      t.string :name
      t.integer :maxStudents
      t.integer :numStudents
      t.string :section

      t.timestamps
    end
  end
end
