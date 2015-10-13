module LinkedinConcern
  extend ActiveSupport::Concern
  require 'linkedin'

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
    client = LinkedIn::Client.new(linkedin_consumer_key, linkedin_consumer_secret)
    client.authorize_from_access(linkedin_oauth_token, linkedin_oauth_token_secret)
    client  
  end

  module ClassMethods
    def linkedin_dependencies_missing
      if ENV['LINKEDIN_OAUTH_KEY'].blank? || ENV['LINKEDIN_OAUTH_SECRET'].blank?
        "## Set LINKEDIN_OAUTH_KEY and LINKEDIN_OAUTH_SECRET in your environment to use LinkedIn Agents."
      elsif !defined?(LinkedIn) || !Devise.omniauth_providers.include?(:linkedin)
        "## Include the `linkedin` and `omniauth-linkedin` gems in your Gemfile to use LinkedIn Agents."
      end
    end
  end
end
