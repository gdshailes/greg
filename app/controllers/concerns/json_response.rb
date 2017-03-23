module JsonResponse

  def restrict_api_access
    authenticate_or_request_with_http_token do |token, options|
       token == '1234567890'
    end
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

end