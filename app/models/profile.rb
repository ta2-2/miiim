class Profile < ApplicationRecord
  belongs_to :user, foreign_key: 'id'
  enum gender: { unknown:0, male:1, female:2 }
end
