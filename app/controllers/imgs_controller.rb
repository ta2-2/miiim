class ImgsController < ApplicationController
  
  def new
  end
  
  def update
    
    @profile_img = Profile.find_by(id: params[:id])
    
    if params[:image]
    
    @profile_img.image_name = "#{@profile_img.id}.jpg"
    image = params[:image]
    File.binwrite("public/user_images/#{@profile_img.image_name}",image.read)
    
    if @profile_img.save
      flash[:notice] = "画像を更新しました"
      redirect_to("/profiles/#{@profile_img.id}/edit")
    else
      redirest_to("/profiles/#{@profile_img.id}/edit")
    end
    end
  end
  
  
  def destroy
   
  end
  
end
