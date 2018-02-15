class ShareUser < ApplicationRecord
  
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    token = auth[:credentials][:token]
    secret = auth[:credentials][:secret]
  end
end
