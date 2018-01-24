class User < ApplicationRecord
  has_one :profile, foreign_key: 'id'
  validates :name, presence: true, length: { maximum: 20 }
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
end
