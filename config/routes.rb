Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#show'
  
  resources :locations, except: [:edit,:update,:index]  

  get '/:username', to: 'users#show', as: "user"



end
