Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :applications, only: [:show]
end
