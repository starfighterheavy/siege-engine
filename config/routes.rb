Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sieges do
        resources :attackers
        resources :results
        resources :reports
      end

      resources :attackers do
        resources :targets
      end
    end
  end
end
