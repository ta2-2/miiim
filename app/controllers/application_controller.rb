class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :set_current_user
  before_filter :set_request_from

  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
  
  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end
  
  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end
  
  #return_back and return　でブラウザバックで前ページに戻せるようにするために
  #前ページのURL情報を保存しておくための記述。
  #使いたい各コントローラーの上部で　before_filter :set_request_from　を記述のこと
  
  def set_request_from
    if session[:request_from]
      @request_from = session[:request_from]
    end
    # 現在のURLを保存しておく
    session[:request_from] = request.original_url
  end
  
  # 前の画面に戻る
  def return_back
    if request.referer
      redirect_to :back and return true
    elsif @request_from
      redirect_to @request_from and return true
    end
  end
  
 
  
  
  
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  
  
  
end
