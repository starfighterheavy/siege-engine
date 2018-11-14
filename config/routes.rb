Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sieges, param: :uid do
        resources :volleys, param: :uid do
          member do
            get :wait
            patch :start
            patch :restart
            patch :pause
            patch :cancel
          end
        end

        resources :attackers, param: :uid
      end

      resources :attackers, param: :uid do
        resources :targets, param: :uid
      end

      resources :volleys, param: :uid do
        resources :results, param: :uid
        resources :reports, param: :uid do
          member do
            get :download
          end
        end
      end
    end
  end

  namespace :test do
    resources :secrets
    resources :blogs
  end
end
