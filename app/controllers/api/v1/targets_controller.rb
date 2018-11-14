module Api
  module V1
    class TargetsController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      attr_permitted :priority, :method, :url, :body, :content_type, :authenticated, :uid

      belongs_to :attacker, foreign_key: :uid, owner: :current_access_key

      lookup_param :uid
    end
  end
end
