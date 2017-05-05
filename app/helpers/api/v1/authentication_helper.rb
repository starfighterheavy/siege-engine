module Api
  module V1
    module AuthenticationHelper
      def load_and_authorize_siege
        @siege = @access_key.sieges.find(params[:siege_id])
      end
    end
  end
end
