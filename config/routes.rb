Rails.application.routes.draw do
  resources :sieges do
    resources :attackers
    resources :results
    resources :reports
  end

  resources :attackers do
    resources :targets
  end
end
