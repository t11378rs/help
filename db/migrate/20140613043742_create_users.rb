class CreateUsers < ActiveRecord::Migration
  #データベースに与える変更の定義
  def change
    create_table :users do |t| #データベースを作って
      #属性を追加
      t.string :name	
      t.string :email

      t.timestamps
    end
  end
end
