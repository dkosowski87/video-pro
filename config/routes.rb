Rails.application.routes.draw do
  root 'videos#new'

  resources :videos, only: %i(index new create show)
end
