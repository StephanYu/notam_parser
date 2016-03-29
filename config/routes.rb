Rails.application.routes.draw do
  
  root 'notes#new'

  resources :notes, only: [:new, :create, :index]
  
end
