class HelppostsController < ApplicationController
  before_action :signed_in_user #session_helperで定義してある
  before_action :correct_user,   only: :destroy

  def show
    @helppost = Helppost.find(params[:id])
    @comments = @helppost.comments
    @comment = @comments.build
  end

  def create
  	@helppost = current_user.helpposts.build(helppost_params)
    if @helppost.save
      flash[:success] = "Helppost created!"
      redirect_to root_url
    else
      @feed_items = [] #マイクロポストの投稿が失敗すると、 Homeページは@feed_itemsインスタンス変数を期待しているため、現状では壊れてしまいます (このことはテストスイートを実行して確認できます)。最も簡単な解決方法は、リスト10.42のように空の配列を渡しておくことです11。
      render 'static_pages/home'
    end
  end

  def destroy
    @helppost.destroy
    redirect_to root_url
  end

  private
    def helppost_params
      params.require(:helppost).permit(:title, :image_url, :desired_time, :desired_place, :reward, :detail)
    end

    def comment_params
      params.require(:comment).permit(:text)
    end

    def correct_user
      @helppost = current_user.helpposts.find_by(id: params[:id]) #カレントユーザーに所属するマイクロポストだけが自動的に見つかることが保証されます。この場合、 findではなくfind_byを使用します。これは、前者ではマイクロポストがない場合に例外が発生しますが、後者はnilを返すためです。
      redirect_to root_url if @helppost.nil?
    end

end