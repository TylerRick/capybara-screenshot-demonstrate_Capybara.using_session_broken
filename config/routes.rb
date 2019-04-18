Rails.application.routes.draw do
  resource :home, only: [:show]
  root to: 'home#show'
  get 'home/other'
end
