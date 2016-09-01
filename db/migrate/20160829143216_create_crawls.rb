class CreateCrawls < ActiveRecord::Migration[5.0]
  def change
    create_table :crawls do |t|
      t.text :url
      t.text :products
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
