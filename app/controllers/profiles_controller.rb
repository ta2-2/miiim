class ProfilesController < ApplicationController
  
before_action :authenticate_user!

  def new
    @profile = Profile.new
  end
  
  def create
    
    @profile = Profile.new(profile_params)
    
      
    if @profile.save
      flash[:notice] = "登録が完了しました"
      redirect_to("/users/#{@profile.id}")
      
    else
      render("profiles/new")
    end
    
  end
  
  def edit
    @profile = Profile.find_by(id: params[:id])
  end
  
  def update
  
  @profile = Profile.find_by(id: params[:id])
    
    if @profile.update(profile_params)
 
        flash[:notice] = "ユーザー情報を編集しました"
        redirect_to("/users/#{@profile.id}")
      else
        render("profiles/#{@profile.id}/edit")
    end
  end
  
  def destroy
    @profile = Profile.find_by(id: params[:id])
    @profile.destroy
    flash[:notice] = "ユーザーアカウントを削除しました"
    redirect_to("/")
  end
  

 private
 
 def profile_params
   params.require(:profile).permit(:content,:area, :gender, :image_name, :interests, :birth_date, :job)
 end
 

end
