class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find_by(id: params[:id])
    @profile = Profile.find_by(id: params[:id])
    
    if !@profile
      redirect_to("/profiles/new")
    end
  end

end
