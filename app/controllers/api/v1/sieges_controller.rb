module Api
  module V1
    class SiegesController < RestApiController
      private def resource_owner
        @access_key
      end

      private def resource_create_permitted_params
        [:name, :store_body]
      end
      alias :resource_update_permitted_params :resource_create_permitted_params
    end
  end
end
