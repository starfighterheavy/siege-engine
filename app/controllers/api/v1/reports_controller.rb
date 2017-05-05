module Api
  module V1
    class ReportsController < RestApiController
      resource_owner_name :siege

      private def resource_create_permitted_params
        [:name]
      end
      alias :resource_update_permitted_params :resource_create_permitted_params
    end
  end
end
