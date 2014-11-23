class CreateMinUrlRequests < ActiveRecord::Migration
  def change
    create_table :min_url_requests do |t|
      t.string :ip
      t.string :ref_url
      t.string :browser
      t.string :platform
      t.string :country
      t.references :min_url, index: true, null: false

      t.timestamps
    end
  end
end
