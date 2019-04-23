Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'public_profile', info_fields: 'id, name, link'
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], scope: 'profile', image_aspect_ratio: 'square', image_size: 48, access_type: 'online', name: 'google'
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'], scope: 'r_liteprofile', fields: ['id', 'first-name', 'last-name', 'location', 'picture-url', 'public-profile-url']
end
=begin
  Now let's return the callback URL. This is the URL where a user will be redirected to inside the app after successful authentication and approved authentication(the request will also contain's user's data and token). All OmniAuth strategies expect the callback URL to equal to "/auth/:provider/callback". :provider takes the name of the strategy("twitter", "facebook", "linkedin", etc) as listed in the initializer.
  
  One of the possible configuration for rails set up for twitter omniauth gem is given below:-

  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, "API_KEY", "API_SECRET", {
      secure_image_url: 'true',
      image_size: 'original',
      authorize_params: {
        force_login: 'true',
        lang: 'pt'
      }
    }
  
=end