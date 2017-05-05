module Api
  module V1
    class TargetsController < RestApiController
      before_action :authorize_attacker

      resource_owner_name :attacker

      private def resource_create_params
        params.require(:target)
              .permit(:priority, :method, :url, :body, :content_type)
              .merge(siege_id: @siege.id)
      end

      private def resource_update_permitted_params
        [:priority, :method, :url, :body, :content_type]
      end

      private def authorize_attacker
        @siege = @access_key.sieges.find(resource_owner.siege_id)
      end
    end
  end
end
