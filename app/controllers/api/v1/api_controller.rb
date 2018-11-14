require 'rapido'

module Api
  module V1
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate!

      private

      def current_access_key
        @access_key ||= authenticate_with_http_basic { |u, p| AccessKey.authenticate(u, p) }
      end

      def authenticate!
        return if current_access_key
        head :unauthorized
      end
    end
  end
end
