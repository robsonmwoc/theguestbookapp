Rails.application.routes.draw do
  root 'entries#index'
  resources :entries, except: :update
end
