class CommentsController < ApplicationController
  before_action :signed_in_user

  def create #コメントを投稿する
  	@comment = current_helppost.comments.new(:user_id => current_user.id, :text => params[:comment][:text])
  	if @comment.save
  		flash[:success] = "Comment posted"
  		redirect_to "/helpposts/#{@comment.helppost.id}"
  		#redirect_to root_url リダイレクト先は後で考える
  	else
  		redirect_to root_url
      #render 'static_pages/home' #どうしようか考え中。これは適当
  	end
  end

  private
  	def comment_params
  		params.require(:comment).permit(:text, :user_id)
  	end

end