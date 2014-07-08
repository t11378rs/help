class Helppost < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	default_scope -> { order('created_at DESC') }
	mount_uploader :image_url, ImageUploader
	#attr_accessible :image_url
	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 100 }
	#validates :image_url, presence: true
	validates :desired_time, presence: true, length: { maximum: 50 }
	validates :desired_place, presence: true, length: { maximum: 50 }
	validates :reward, presence: true, length: { maximum: 50 }
	validates :detail, presence: true

	#画像アップロード用
end


=begin
belong_to ユーザー
ユーザー     user_id:integer
タイトル     title:string
画像     image_url:string
いつ助けて欲しいか     desired_time:string
どこで助けて欲しいか     desired_place:string
報酬     reward:string
詳細     detail:text
has_many コメント
=end