module SessionsHelper

  def current_helppost
    @current_helppost = Helppost.find(params[:id]) #@current_userが未定義の場合にのみ、@current_userインスタンス変数に記憶トークンを設定します
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user) #セッター
    @current_user = user
  end

  def current_user #ゲッター
    remember_token = User.encrypt(cookies[:remember_token]) #remember_tokenを使用して現在のユーザを検索する
    @current_user ||= User.find_by(remember_token: remember_token) #@current_userが未定義の場合にのみ、@current_userインスタンス変数に記憶トークンを設定します
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
