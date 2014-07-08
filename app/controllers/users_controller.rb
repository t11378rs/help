class UsersController < ApplicationController

  #indexとeditとupdateとdestroyにはsigned_in_userフィルタをかける
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  #editとupdateにはcurrent_userフィルタをかける
  before_action :correct_user, only: [:edit, :update]
  #destroyにはadmin_userフィルタをかける
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id]) #http://localhost:4000/users/1 なら params[:id]は1になる
    @helpposts = @user.helpposts.paginate(page: params[:page])
  end

  def new #新規ユーザー用のビューを出力する
  	@user = User.new
  end

  def create #POSTリクエストに応答する
  	@user = User.new(user_params)
  	if @user.save # 保存の成功をここで扱う。
      sign_in @user
  	  flash[:success] = "Welcome to the HELP!"
      redirect_to @user 
    else
      render 'new' #失敗したらリロード
    end
  end

  def edit #PATCHリクエストに応答する
    #@user = User.find(params[:id]) #current_userメソッドでかわりにやっている
  end

  def update
    #@user = User.find(params[:id]) #current_userメソッドでかわりにやっている
    if @user.update_attributes(user_params) #属性のハッシュを受け取り、成功時には更新と保存を続けて同時に行います (保存に成功した場合はtrueを返します)
      flash[:success] = "Profile updated"
      redirect_to @user
    else #失敗した場合
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private  #privateの下に書いたのは全部privateになるから注意
    def user_params
  	   params.require(:user).permit(:name, :email, :password, :password_confirmation) #adminは触れないようにしてある
    end

    #Before actions

    #今はsessions_helperで処理している
    #def signed_in_user
    #  unless signed_in?
    #    store_location #リクエストされたurlを:return_toってキーでセッション変数に保存する。sessions_helperに記載してある
    #    redirect_to signin_url, notice: "Please sign in."
    #  end
    #end

=begin
      ↑は
      flash[:notice] = "Please sign in."
      redirect_to signin_url
      と同じ
      flashスタイルでは、:notice、:success、:errorの3つのキーを指定できます
=end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) #current_user?(user)はsessions_helper.rb内で定義
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
