Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sieges do
        resources :volleys do
          member do
            patch :start
            patch :pause
            patch :cancel
          end

          resources :results
          resources :reports do
            get :download
          end
        end

        resources :attackers
      end

      resources :attackers do
        resources :targets
      end
    end
  end
end
