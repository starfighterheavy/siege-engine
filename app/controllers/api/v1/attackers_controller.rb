module Api
  module V1
    class AttackersController < ApiController
      include Rapido::Controller
      include Rapido::ApiController

      attr_permitted :username, :password, :username_field, :password_field,
          :new_session_url, :create_session_url, :sign,
          :registration_required, :new_registration_url, :create_registration_url,
          :registration_form_values, :uid

      belongs_to :siege, foreign_key: :uid, owner: :current_access_key

      lookup_param :uid
    end
  end
end
