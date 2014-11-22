class CreateMinUrls < ActiveRecord::Migration
  def change
    create_table :min_urls do |t|
      t.string :url, null: false
      t.string :token, null: false
      t.string :token_alias

      t.timestamps
    end
    add_index :min_urls, :url, unique: true
    add_index :min_urls, :token, unique: true
    add_index :min_urls, :token_alias, unique: true
  end
end
