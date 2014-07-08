class Comment < ActiveRecord::Base
	belongs_to :helppost
	belongs_to :user
	default_scope -> { order('created_at ASC') }
	validates :text, presence: true, length:{maximum: 200}
	validates :helppost_id, presence: true
	validates :user_id, presence: true
end
