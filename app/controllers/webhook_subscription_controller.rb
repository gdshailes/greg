class WebhookSubscriptionController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    # Show all rides
    @subs = ApiSubscription.all
  end

end