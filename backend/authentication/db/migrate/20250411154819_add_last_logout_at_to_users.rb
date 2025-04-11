class AddLastLogoutAtToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :last_logout_at, :datetime
  end
end
