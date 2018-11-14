module Api
  module V1
    class VolleysController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      attr_permitted :name, :strikes, :delay, :uid

      belongs_to :siege, foreign_key: :uid, owner: :current_access_key

      lookup_param :uid

      class WaitedTooLong < StandardError; end

      rescue_from WaitedTooLong do |e|
        render json: { errors: [ e.to_s ] }, status: 500
      end

      def restart
        volley.restart!
        render json: volley.to_h
      end

      def start
        unless volley.status.nil?
          render json: { errors: [ 'Volley already been started or canceled' ] }, status: 422
        else
          update_status('started')
        end
      end

      def pause
        if [nil, 'paused', 'canceled'].include? volley.status
          render json: { errors: [ 'Volley is not running' ] }, status: 422
        else
          update_status('paused')
        end
      end

      def cancel
        if volley.status == 'canceled'
          render json: { errors: [ 'Volley has already been canceled' ] }, status: 422
        else
          update_status('canceled')
        end
      end

      WAIT_MAX = 23
      WAIT_INCREMENT = 0.1
      def wait
        timer = 0
        increment = WAIT_INCREMENT
        while volley.status != 'done'
          raise WaitedTooLong unless timer <= WAIT_MAX
          sleep increment
          timer += increment
          volley.reload
       end
        head :ok
      end

      private def update_status(status)
        volley.update_attribute(:status, status)
        render json: volley.to_h
      end
    end
  end
end
