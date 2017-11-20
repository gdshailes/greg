class Facebook

  require 'koala'

  attr_accessor :redirect_url

  def initialize(redirect_url = nil)
    @redirect_url = redirect_url
  end

  def fb_permissions_url
    oauth.url_for_oauth_code(:permissions => "publish_actions")
  end

  def oauth
    @oauth ||= Koala::Facebook::OAuth.new(ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], redirect_url)
  end

end
