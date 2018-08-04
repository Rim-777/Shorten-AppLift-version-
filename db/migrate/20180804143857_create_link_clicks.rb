class CreateLinkClicks < ActiveRecord::Migration[5.2]
  def change
    create_table :link_clicks do |t|
      t.integer :link_id, index: true, foreign_key: true
      t.datetime :created_at, null: false
    end
  end
end
