class AddStatusToStories < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :status, :string
  end
end
