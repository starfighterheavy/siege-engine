module Api
  module V1
    class SiegesController < ApiController
      def create
        siege = @access_key.sieges.new(siege_params)
        if siege.save
          render json: { id: siege.id }
        else
          render json: { errors: siege.errors.full_messages }
        end
      end

      def index
        render json: @access_key.sieges.map { |s| { id: s.id, strikes: s.strikes } }
      end

      private

        def siege_params
          params.require(:siege).permit(:strikes)
        end
    end
  end
end
