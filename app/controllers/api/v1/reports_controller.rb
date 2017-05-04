module Api
  module V1
    class ReportsController
      before_action :load_and_authorize_siege
      before_action :load_and_authorize_report, only: [:show]

      def create
        report = @siege.reports.new(status: 'pending')
        if report.save
          render json: { id: report.id }
        else
          render json: { errors: report.errors.full_messages }, status: 422
        end
      end

      def index
        render json: @siege.reports.map { |r| { id: r.id, status: r.status } }
      end

      def show
        render json: { id: @report.id, status: @report.status, content: @report.content }
      end

      private

        def load_and_authorize_report
          @report = @siege.reports.find!(params[:id])
        end
    end
  end
end
