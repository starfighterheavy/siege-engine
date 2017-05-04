module Api
  module V1
    class TargetsController < ApiController
      before_action :load_and_authorize_attacker

      def create
        target = @attacker.targets.new(target_params)
        if target.save
          render json: { id: target.id }
        else
          render json: { errors: target.errors.full_messages }, status: 402
        end
      end

      def index
        render json: @attacker.targets.map { |t|
          {
            id: t.id, priority: t.priority,
            method: t.method, url: t.url, body: t.body, content_type: t.content_type
          }
        }
      end

      private

        def target_params
          params.require(:target).permit(:priority, :method, :url, :body, :content_type)
        end

        def load_and_authorize_attacker
          @attacker = Attacker.find(params[:attacker_id])
          @siege = @access_key.sieges.find!(@attacker.siege_id)
        end
    end
  end
end
