Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sieges do
        resources :volleys do
          member do
            patch :start
            patch :restart
            patch :pause
            patch :cancel
          end
        end

        resources :attackers
      end

      resources :attackers do
        resources :targets
      end

      resources :volleys do
        resources :results
        resources :reports do
          get :download
        end
      end
    end
  end
end
