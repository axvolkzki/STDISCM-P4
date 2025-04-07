class AddColumnsToCourses < ActiveRecord::Migration[8.0]
  def change
    change_table :courses do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.integer :maxStudents, null: false
      t.integer :numStudents, null: false
      t.integer :section, null: false
    end
  end
end
