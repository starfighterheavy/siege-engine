module Api
  module V1
    class AttackersController < ApiController
      before_action :load_and_authorize_siege

      def create
        attacker = @siege.attackers.new(attacker_params)
        if attacker.save
          render json: { id: attacker.id }
        else
          render json: { errors: attacker.errors.full_messages }
        end
      end

      def index
        render json: @siege.attackers.map { |a| { id: a.id, username: a.username, login_url: a.login_url } }
      end

      private

      def attacker_params
        params.require(:attacker).permit(:username, :password, :username_field, :password_field, :login_url)
      end
    end
  end
end
