module Api
  module V1
    class ResultsController < RestApiController
      before_action :authorize_volley

      resource_owner_name :volley
    end
  end
end
