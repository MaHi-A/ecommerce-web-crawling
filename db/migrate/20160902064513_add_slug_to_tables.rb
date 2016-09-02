class AddSlugToTables < ActiveRecord::Migration[5.0]
  def change
    # Add slug for users
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true

    # Add slug for crawls
    add_column :crawls, :slug, :string
    add_index :crawls, :slug, unique: true
  end
end
