OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '544834402575069', '7870918b18eee1324c1e8d5f97b78f6c', {:client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}}
end
