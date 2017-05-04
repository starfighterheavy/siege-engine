module Api
  module V1
    class ResultsController < ApiController
      before_action :load_and_authorize_siege

      def index
        render json: @siege.results.last(1000).map { |r| { id: r.id, target_id: r.target_id, code: r.code, time: r.time } }
      end
    end
  end
end
