Rails.application.routes.draw do
  resources :applications
  resources :shelters
  resources :pets

  get '/', to: 'application#welcome'

  post '/applications/:id/pets/:id', to: 'application_pets#create'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/admin/shelters', to: 'admin_shelters#index'
  get '/admin/applications/:id', to: 'admin_applications#show'
  patch '/admin/applications/:id', to: 'admin_applications#update', as: 'adminapp'
end
