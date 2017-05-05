module Api
  module V1
    class SiegesController < RestApiController

      private def resource_owner
        @access_key
      end

      private def resource_create_permitted_params
        [:strikes]
      end

      private def resource_update_permitted_params
        [:strikes]
      end
    end
  end
end
