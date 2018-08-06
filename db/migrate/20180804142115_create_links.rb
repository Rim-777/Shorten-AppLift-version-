class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.text :url, null: false
      t.string :shortcode, null: false, index: { unique: true }
      t.datetime :created_at, null: false
    end
  end
end


