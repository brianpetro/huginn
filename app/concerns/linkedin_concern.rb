module LinkedInConcern
  extend ActiveSupport::Concern

  included do
    include Oauthable

    valid_oauth_providers :linkedin
  end

  def linkedin_consumer_key
    ENV['LINKEDIN_OAUTH_KEY']
  end

  def linkedin_consumer_secret
    ENV['LINKEDIN_OAUTH_SECRET']
  end

  def linkedin_oauth_token
    service.token
  end

  def linkedin_oauth_token_secret
    service.secret
  end

  def linkedin
    LinkedIn.configure do |config|
      config.consumer_key = linkedin_consumer_key
      config.consumer_secret = linkedin_consumer_secret
      config.oauth_token = linkedin_oauth_token
      config.oauth_token_secret = linkedin_oauth_token_secret
    end
    
    LinkedIn::Client.new
  end
end
