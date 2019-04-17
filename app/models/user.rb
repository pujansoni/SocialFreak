class User < ApplicationRecord
  class << self
    def from_omniauth auth_hash
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      if user.provider == "twitter"
        user.url = auth_hash['info']['urls']["Twitter"]
        user.location = auth_hash['info']['location']
      end
      user.name = auth_hash['info']['name']
      user.image_url = auth_hash['info']['image']
      user.save!
      user
    end
  end
end
# find_or_create_by ensures that we are not creating the same use multiple times. The method stores all the required data, saves the user and then returns it. If you are interested, the user's token can normally be accessed as: auth_hash["credentials"]["token"] for token and auth_hash["credentials"]["secret"] for secret