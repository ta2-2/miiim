class ProfilesController < ApplicationController
  
  def edit
    @profile = Profile.find_by(id: params[:id])
  end
  
  def update
  end

end
