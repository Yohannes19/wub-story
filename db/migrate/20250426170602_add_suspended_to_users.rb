class AddSuspendedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :suspended, :boolean
  end
end
