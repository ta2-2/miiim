class ShareUsersController < ApplicationController
  def new
    @share_user = ShareUser.find_or_create_from_auth(request.env['omniauth.auth'])
    @u_id = ShareUser.find_by(user_id: current_user.id)
    
      if @u_id
        flash[:notice] = "このアカウントは、すでにツイッターが登録されてます。"
        redirect_to("/")
    
      else
        omniauth = request.env['omniauth.auth']
     
        @share_user = ShareUser.new(
          provider: omniauth.provider,
          uid: omniauth.uid,
          nickname: omniauth.info.nickname,
          user_id: current_user.id,
          token: omniauth.credentials.token,
          secret: omniauth.credentials.secret )
          
        @share_user.save
        flash[:notice] = "ツイッターを登録しました。"
      
        redirect_to("/")
      end
  end
end
