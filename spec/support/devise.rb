require 'devise/test_helpers'

module Devise
  module Test
    module ControllerHelpers
      def sign_in(user = double('user', id: 1))
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end
    end
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
end
