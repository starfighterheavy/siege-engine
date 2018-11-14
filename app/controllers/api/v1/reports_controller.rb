module Api
  module V1
    class ReportsController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      attr_permitted :name, :uid

      belongs_to :volley, foreign_key: :uid, owner: :current_access_key

      lookup_param :uid

      def download
        render plain: report.content, content_type: "text/csv"
      end
    end
  end
end
