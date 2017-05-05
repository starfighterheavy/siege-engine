module Api
  module V1
    module AuthenticationHelper
      private def load_and_authorize_siege
        @siege = @access_key.sieges.find(params[:siege_id])
      end

      private def authorize_volley
        @siege = @access_key.sieges.find(resource_owner.siege_id)
      end
    end
  end
end
