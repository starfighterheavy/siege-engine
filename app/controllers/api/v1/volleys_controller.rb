module Api
  module V1
    class VolleysController < RestApiController
      def restart
        resource.restart!
        render json: resource.to_h
      end

      def start
        unless resource.status.nil?
          render json: { errors: [ 'Volley already been started or canceled' ] }, status: 422
        else
          update_status('started')
        end
      end

      def pause
        if [nil, 'paused', 'canceled'].include? resource.status
          render json: { errors: [ 'Volley is not running' ] }, status: 422
        else
          update_status('paused')
        end
      end

      def cancel
        if resource.status == 'canceled'
          render json: { errors: [ 'Volley has already been canceled' ] }, status: 422
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
