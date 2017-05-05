module Api
  module V1
    class ReportsController < RestApiController
      before_action :authorize_volley

      resource_owner_name :volley

      def download
        render plain: resource.content, content_type: "text/csv"
      end

      private def resource_create_permitted_params
        [:name]
      end
      alias :resource_update_permitted_params :resource_create_permitted_params
    end
  end
end
