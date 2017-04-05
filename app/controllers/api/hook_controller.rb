class Api::HookController < ActionController::Base

  include JsonResponse
  before_action :restrict_api_access
  respond_to :json

  def subscribe
    # Zapier will post its subscription requests like this:
    #   POST <subscribe_endpoint> \
    #   -H Authenticated: Somehow \
    #   -H Content-Type: application/json \
    #   -d '{"target_url": "https://hooks.zapier.com/<unique_target_url>",
    #        "event": "user_created"}'
<<<<<<< HEAD
    sub = ApiSubscription.new(target_url: params[:target_url], event: params[:event])
=======

    sub = ApiSubscription.new(target_url: params[:target_url], event: params[:event])

>>>>>>> 86ee10a426418c619bcb1a94686e866338cdfd3e
    # We can't allow duplicate subscription URLs, so check for that now.
    if ApiSubscription.find_by(target_url: sub.target_url).nil?
      if sub.valid?
        sub.save
        json_response({"id": sub.id}, :created)
      else
       json_response({"error": "invalid subscription"}, :server_error)
      end
    else
      json_response({"error": "target_url already subscribed"}, :conflict)
    end
<<<<<<< HEAD
  end

  def unsubscribe
    head :ok
  end

=======

  end
>>>>>>> 86ee10a426418c619bcb1a94686e866338cdfd3e
end