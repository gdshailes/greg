class Facebook

  require 'koala'

  def self.fb_permissions_url
    @oauth.url_for_oauth_code(:permissions => "publish_actions")
  end

  private

  def oauth
    @oauth ||= Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'])
  end

end
