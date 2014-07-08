class User < ActiveRecord::Base
	#has_many :microposts, dependent: :destroy #ユーザのポストはユーザーと一緒に破棄される
	has_many :helpposts, dependent: :destroy #ユーザのポストはユーザーと一緒に破棄される
	has_many :comments

	before_save {self.email = email.downcase} #email属性を強制的に小文字に変換します。
	validates :name, presence: true, length: {maximum: 50} #name属性の存在/長さを検証する validates(:name, presence: true)と同意
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #メアドの正規表現
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false} #email属性の存在/形式/ユニークネス(大文字小文字を無視)を検証する
	has_secure_password
	validates :password, length: {minimum: 6}
=begin
	↑
	パスワードの確認入力は、入力ミスを減らすためにWebで広く使用されています。
	パスワード確認の強制はコントローラの階層でも行うことができますが、モデルの中でActive Recordを使用して制限を与えるのが慣習になっています。
	そのためには、password属性とpassword_confirmation属性をUserモデルに追加し、レコードをデータベースに保存する前に2つの属性が一致するように要求します。
	これまでに使用した属性と異なり、パスワード関連の属性は「仮想」にする点に注意してください。
	つまり、これらの属性は一時的にメモリ上に置き、データベースには保存されないようにします。
=end
  	def feed
    	# このコードは準備段階です。
    	# 完全な実装は第11章「ユーザーをフォローする」を参照してください。
    	Helppost.where("user_id = ?", id) #上の疑問符があることで、SQLクエリにインクルードされる前にidが適切にエスケープされることを保証してくれるため、SQLインジェクションと呼ばれる深刻なセキュリティホールを避けることができます。この場合のid属性は単なる整数であるため危険はありませんが、SQL文にインクルードされる変数を常にエスケープする習慣はぜひ身につけてください。
  	end

	def User.new_remember_token
    	SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
	end


  	private
	    def create_remember_token
	    	self.remember_token = User.encrypt(User.new_remember_token)
	    end

end