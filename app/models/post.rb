class Post < ActiveRecord::Base
    
  def user
    return User.where(id: self.user_id)
  end
end
