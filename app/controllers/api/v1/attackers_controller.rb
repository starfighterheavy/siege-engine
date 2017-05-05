module Api
  module V1
    class AttackersController < RestApiController
      before_action :load_and_authorize_siege

      private def resource_owner
        @siege
      end

      private def resource_create_permitted_params
        [:username, :password, :username_field, :password_field, :login_url]
      end
      alias :resource_update_permitted_params :resource_create_permitted_params
    end
  end
end
