class UsersController < ApplicationController

before_action :ensure_current_user, {only:[:edit ,:destroy]}  


  def show
    @user = User.find_by(id: params[:id])
    
    #user.rbファイルでpostsアクション指定
    @posts = @user.post
  end
  

end
