class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string #上のコードでは、add_columnメソッドを使用してpassword_digest カラムをusersテーブルに追加しています。
  end
end
