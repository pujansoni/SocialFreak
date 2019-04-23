class User < ApplicationRecord
  class << self
    def from_omniauth auth_hash
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = get_name user.provider, auth_hash['info']
      user.image_url = get_image_url user.provider, auth_hash['info']
      user.url = get_social_url_for user.provider, auth_hash['info']
      user.location = get_social_location_for user.provider, auth_hash['info']
      user.save!
      user
    end

    private

      def get_image_url(provider, info_hash)
        case provider
        when 'linkedin'
          info_hash['picture_url']
        else
          info_hash['image']
        end
      end

      def get_name(provider, info_hash)
        case provider
        when 'linkedin'
          info_hash['first_name'] + info_hash['last_name']
        else
          info_hash['name']
        end
      end

      def get_social_location_for(provider, location_hash)
        case provider
        when 'linkedin'
          location_hash['name']
        when 'twitter'
          location_hash['location']
        when 'facebook'
          ""
        when 'google'
          ""
        end
      end

      def get_social_url_for(provider, urls_hash)
        case provider
        when 'linkedin'
          urls_hash['public_profile']
        when 'twitter'
          urls_hash['urls'][provider.capitalize]
        when 'facebook'
          ""
        when 'google'
          urls_hash['urls']['google']
        end
      end
  end
end
# find_or_create_by ensures that we are not creating the same use multiple times. The method stores all the required data, saves the user and then returns it. If you are interested, the user's token can normally be accessed as: auth_hash["credentials"]["token"] for token and auth_hash["credentials"]["secret"] for secret