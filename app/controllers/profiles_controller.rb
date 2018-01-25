class ProfilesController < ApplicationController
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
      
    if @profile.save
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/#{@user.id}")
      
    else
      render("profiles/new")
    end
    
  end
  
  def edit
    @current_user = current_user
    @profile = Profile.find_by(id: params[:id])
    
    if @profile == nil
      @profile = Profile.new
    end
    
  end
  
  def update
    @profile = Profile.find_by(id: params[:id])
    @profile.name = params[:name]
    @profile.email = params[:email]
    if @profile.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "ユーザーアカウントを削除しました"
    redirect_to("/")
  end

end
