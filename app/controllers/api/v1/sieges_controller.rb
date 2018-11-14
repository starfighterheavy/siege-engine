module Api
  module V1
    class SiegesController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      attr_permitted :uid, :name, :store_body

      belongs_to :access_key, getter: :current_access_key

      lookup_param :uid
    end
  end
end
