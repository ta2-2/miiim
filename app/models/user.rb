class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
         
  def post
    return Post.where(user_id: self.id)
  end
  
end
