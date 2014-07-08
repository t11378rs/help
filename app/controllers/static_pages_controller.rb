#コントローラーで書くのは主に、ビューで使う変数

class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @helppost  = current_user.helpposts.build
      #@helppost_id = Helppost.find(params[:id]).helppost_id ←homeにヒモ付のため
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  private
    def helppost_params
      params.require(:helppost).permit(:title, :image_url, :desired_time, :desired_place, :reward, :detail)
    end
end
