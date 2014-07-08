class CreateHelpposts < ActiveRecord::Migration
  def change
    create_table :helpposts do |t|
      t.integer :user_id
      t.string :title
      t.string :image_url
      t.string :desired_time
      t.string :desired_place
      t.string :reward
      t.text :detail

      t.timestamps
    end
    add_index :helpposts, [:user_id, :created_at]
  end
end
