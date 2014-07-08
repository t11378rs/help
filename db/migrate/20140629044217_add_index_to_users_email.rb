class AddIndexToUsersEmail < ActiveRecord::Migration
  #データベースに与える変更の定義
  def change
  	add_index :users, :email, unique: true #usersテーブルのemailカラムにインデックスを追加するためにadd_indexというRailsのメソッドを使っています。インデックス自体は一意性を強制しませんが、オプションでunique: trueを指定することで強制できるようになります。
  end
end
