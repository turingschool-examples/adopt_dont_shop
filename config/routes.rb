Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :applications, only: [:show, :new, :create]


  resources :pets, only: [:index, :destroy, :show, :edit, :update]

  resources :shelters, only: [:index, :new, :create, :destroy, :show, :edit, :update]

end
