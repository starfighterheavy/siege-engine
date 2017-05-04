module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate

      private

        def authenticate
          access_key = authenticate_with_http_basic { |u, p| AccessKey.authenticate(u, p) }
          if access_key
            @access_key = access_key
          else
            request_http_basic_authentication
          end
        end
    end
  end
end
