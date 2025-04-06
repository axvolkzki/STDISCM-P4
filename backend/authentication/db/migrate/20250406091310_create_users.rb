class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: false do |t|
      t.integer :id, limit: 8, primary_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name
      t.string :password_hash, limit: 60, null: false
      t.boolean :is_professor, default: false, null: false

      t.timestamps
    end
  end
end