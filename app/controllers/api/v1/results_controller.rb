module Api
  module V1
    class ResultsController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      belongs_to :volley, foreign_key: :uid, owner: :current_access_key

      lookup_param :uid

      permit_no_params!
    end
  end
end
