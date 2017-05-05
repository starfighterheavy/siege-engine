module Api
  module V1
    class VolleysController < RestApiController
      def start
        unless resource.status.nil?
          render json: { errors: [ 'Volley already started' ] }, status: 422
        else
          update_status('started')
        end
      end

      def pause
        unless resource.status == 'started'
          render json: { errors: [ 'Volley has not started' ] }, status: 422
        else
          update_status('paused')
        end
      end

      def cancel
        unless resource.status == 'started' || resource.status == 'paused'
          render json: { errors: [ 'Volley has not started or paused' ] }, status: 422
        else
          update_status('canceled')
        end
      end

      resource_owner_name :siege

      private def update_status(status)
        resource.update_attribute(:status, status)
        render json: resource.to_h
      end

      private def resource_create_permitted_params
        [:name, :strikes]
      end
      alias :resource_update_permitted_params :resource_create_permitted_params
    end
  end
end
