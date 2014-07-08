class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :helppost_id

      t.timestamps
    end
    add_index :comments, [:helppost_id, :created_at]
  end
end
